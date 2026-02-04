import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _onboardingKey = 'onboarding_completed';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentUserKey = 'current_user';
  static const String _usersKey = 'registered_users';
  static const String _addressesKey = 'user_addresses';

  // Singleton pattern
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // Onboarding methods
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  // Authentication methods
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  Future<void> setCurrentUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, email);
  }

  Future<void> clearCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // User registration methods
  Future<Map<String, String>> getRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return {};
    return Map<String, String>.from(json.decode(usersJson));
  }

  Future<void> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getRegisteredUsers();
    users[email] = password;
    await prefs.setString(_usersKey, json.encode(users));
  }

  Future<bool> isUserRegistered(String email) async {
    final users = await getRegisteredUsers();
    return users.containsKey(email);
  }

  Future<bool> validateCredentials(String email, String password) async {
    final users = await getRegisteredUsers();
    return users[email] == password;
  }

  // Address management methods
  Future<List<Map<String, String>>> getAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = await getCurrentUser();
    if (currentUser == null) return [];
    
    final addressesJson = prefs.getString('${_addressesKey}_$currentUser');
    if (addressesJson == null) return [];
    
    final List<dynamic> decoded = json.decode(addressesJson);
    return decoded.map((item) => Map<String, String>.from(item)).toList();
  }

  Future<void> saveAddresses(List<Map<String, String>> addresses) async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = await getCurrentUser();
    if (currentUser == null) return;
    
    await prefs.setString('${_addressesKey}_$currentUser', json.encode(addresses));
  }

  Future<void> addAddress(String addressLine1, String addressLine2) async {
    final addresses = await getAddresses();
    addresses.add({
      'line1': addressLine1,
      'line2': addressLine2,
    });
    await saveAddresses(addresses);
  }

  Future<void> deleteAddress(int index) async {
    final addresses = await getAddresses();
    if (index >= 0 && index < addresses.length) {
      addresses.removeAt(index);
      await saveAddresses(addresses);
    }
  }

  // Logout method
  Future<void> logout() async {
    await setLoggedIn(false);
    await clearCurrentUser();
  }
}

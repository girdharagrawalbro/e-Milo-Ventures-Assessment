# Flutter App for e-Milo Ventures Assessment

A Flutter application demonstrating app navigation, local data persistence, authentication flows, and basic UI/UX principles.

## 📋 Project Overview

This application showcases:
- One-time onboarding flow
- Local authentication (login/signup)
- Persistent data management
- Clean UI/UX design

## 🏗️ Project Structure

```
e-Milo Ventures Assessment/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── services/
│   │   └── storage_service.dart       # Local storage management
│   └── screens/
│       ├── splash_screen.dart         # Animated splash screen
│       ├── onboarding_screen.dart     # One-time onboarding flow
│       ├── login_screen.dart          # Login functionality
│       ├── signup_screen.dart         # User registration
│       └── home_screen.dart           # Address management
├── pubspec.yaml                       # Dependencies
├── analysis_options.yaml              # Linting rules
└── README.md                          # This file
```

## 🚀 Setup & Installation

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator or iOS Simulator (or physical device)

### Installation Steps

1. **Clone or navigate to the project directory:**
   ```bash
   cd "d:\PROJECTS\e-milo Ventures Assessment\flutter_assessment"
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

4. **Build for release (optional):**
   ```bash
   # Android
   flutter build apk
   
   # iOS
   flutter build ios
   ```

## 📱 Features

### 1. Splash Screen
- Animated entrance with fade and scale effects
- Gradient background with branding
- Automatic navigation based on app state
- 3-second display duration

### 2. One-Time Onboarding Flow
- **3 informative pages:**
  - Welcome page
  - Secure Authentication info
  - Address Management info
- Swipe navigation between pages
- Page indicators (dots)
- Skip button to bypass onboarding
- **Never appears again** after navigating to login (persisted in local storage)

### 3. Authentication Module

#### Login Screen
- Email and password fields with validation
- Password visibility toggle
- Only registered accounts can login
- Error messages for:
  - Account not found
  - Invalid password
- Navigation to signup screen

#### Signup Screen
- Full name, email, password, and confirm password fields
- Email format validation
- Password minimum length (6 characters)
- Password confirmation matching
- Prevents duplicate email registration
- Auto-login after successful signup

#### Persistent Login
- Users remain logged in after app restart
- No re-authentication required until logout

### 4. Home Screen (Address Management)
- User profile header with email display
- **Add Address Form:**
  - Address Line 1 (street, P.O. box)
  - Address Line 2 (city, state, ZIP)
  - "Done" button to save
- **Saved Addresses List:**
  - Card-based display
  - Delete functionality with confirmation
  - Address count badge
- Empty state when no addresses saved
- Logout button with confirmation dialog

## 🔄 Navigation Flow

```
┌─────────────────────────────────────────────────────────────┐
│                      APP LAUNCH                              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │  Splash Screen  │
                    │   (3 seconds)   │
                    └─────────────────┘
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
    ┌─────────────────┐ ┌───────────┐ ┌─────────────┐
    │   Onboarding    │ │   Login   │ │    Home     │
    │ (First Launch)  │ │  Screen   │ │   Screen    │
    └─────────────────┘ └───────────┘ └─────────────┘
              │               │               │
              │               │               │
              ▼               ▼               │
        ┌───────────┐   ┌───────────┐        │
        │   Login   │◄──│  Signup   │        │
        │  Screen   │──►│  Screen   │        │
        └───────────┘   └───────────┘        │
              │               │               │
              └───────┬───────┘               │
                      │                       │
                      ▼                       │
              ┌─────────────┐                 │
              │    Home     │◄────────────────┘
              │   Screen    │     (Logout)
              └─────────────┘
```

### Flow Scenarios:

| Scenario | Navigation Path |
|----------|-----------------|
| First Launch | Splash → Onboarding → Login |
| After Onboarding (not logged in) | Splash → Login |
| Logged In User | Splash → Home |
| After Logout | Login Screen |

## 💾 Data Persistence

### Storage Service Methods

The `StorageService` class provides the following methods:

#### Onboarding
| Method | Description |
|--------|-------------|
| `isOnboardingCompleted()` | Returns `true` if onboarding was completed |
| `setOnboardingCompleted()` | Marks onboarding as completed |

#### Authentication
| Method | Description |
|--------|-------------|
| `isLoggedIn()` | Returns `true` if user is logged in |
| `setLoggedIn(bool)` | Sets login state |
| `getCurrentUser()` | Returns current user's email |
| `setCurrentUser(email)` | Sets current user |
| `clearCurrentUser()` | Clears current user |
| `logout()` | Logs out user (clears login state) |

#### User Registration
| Method | Description |
|--------|-------------|
| `getRegisteredUsers()` | Returns all registered users |
| `registerUser(email, password)` | Registers a new user |
| `isUserRegistered(email)` | Checks if email is registered |
| `validateCredentials(email, password)` | Validates login credentials |

#### Address Management
| Method | Description |
|--------|-------------|
| `getAddresses()` | Returns all addresses for current user |
| `saveAddresses(addresses)` | Saves address list |
| `addAddress(line1, line2)` | Adds a new address |
| `deleteAddress(index)` | Deletes address at index |

### Storage Keys

| Key | Purpose |
|-----|---------|
| `onboarding_completed` | Tracks if onboarding is done |
| `is_logged_in` | Tracks login state |
| `current_user` | Stores current user email |
| `registered_users` | JSON map of email:password |
| `user_addresses_{email}` | JSON array of addresses per user |

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2  # Local data persistence
  cupertino_icons: ^1.0.6     # iOS-style icons
```

## 🎨 UI/UX Features

- **Material Design 3** with custom color scheme
- **Gradient backgrounds** on splash and headers
- **Animated transitions** (fade, scale, page transitions)
- **Form validation** with helpful error messages
- **Loading indicators** during async operations
- **Snackbar notifications** for user feedback
- **Confirmation dialogs** for destructive actions
- **Responsive layouts** that work on various screen sizes
- **Password visibility toggles**
- **Empty states** with helpful messages

## 🔐 Security Notes

> ⚠️ **Important:** This is a demonstration app. In production:
> - Never store passwords in plain text
> - Use proper encryption and hashing (e.g., bcrypt)
> - Consider using secure storage solutions
> - Implement proper session management
> - Use HTTPS for any network communication

## 🧪 Testing the App

### Test Scenario 1: First Launch
1. Install and open the app
2. Verify splash screen appears with animation
3. Verify onboarding screen appears
4. Swipe through all 3 pages
5. Tap "Get Started"
6. Verify login screen appears

### Test Scenario 2: Onboarding Persistence
1. Close the app completely
2. Reopen the app
3. Verify onboarding does NOT appear
4. Verify login screen appears directly

### Test Scenario 3: User Registration
1. On login screen, tap "Sign Up"
2. Fill in all fields
3. Tap "Sign Up"
4. Verify success message
5. Verify navigation to home screen

### Test Scenario 4: Login Persistence
1. Close the app completely
2. Reopen the app
3. Verify home screen appears (no login required)

### Test Scenario 5: Address Management
1. On home screen, enter address details
2. Tap "Done"
3. Verify address appears in list
4. Add multiple addresses
5. Close and reopen app
6. Verify all addresses are still present

### Test Scenario 6: Logout
1. Tap logout button
2. Confirm logout
3. Verify navigation to login screen
4. Close and reopen app
5. Verify login screen appears (not home)

## 📄 License

This project is created for assessment purposes for e-milo Ventures.

## 👨‍💻 Author

**Girdhar Agrawal**  
Flutter Intern Assessment for e-milo Ventures  
📅 February 2026

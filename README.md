# Bupra - Mini Chat Application

Bupra is a minimal, production-ready messaging application built with Flutter and Firebase.

## 🚀 Features

- ✅ **Authentication**: Email/password login
- ✅ **Discord-Style Usernames**: Multiple users can choose the same base username, system automatically adds unique number (e.g., bugra#1234, bugra#1256)
- ✅ **Users & Friends**: User search, add friends
- ✅ **One-to-One Chat**: Real-time messaging
- ✅ **Group Chat**: Create groups and group messaging
- ✅ **Image Messaging**: Pick images from gallery and send
- ✅ **Premium Dark Theme**: Modern and elegant dark theme

## 📋 Requirements

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Firebase account
- Android Studio / Xcode (for platform-specific development)

## 🔧 Installation

### 1. Clone the Project

```bash
git clone <repository-url>
cd bupra
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

For detailed Firebase setup instructions, see [FIREBASE_MANUAL_SETUP.md](FIREBASE_MANUAL_SETUP.md).

**Quick Start:**

1. Create a new project in Firebase Console
2. Add Android app (Package: `com.akdbt.bupra`)
3. Download `google-services.json` and place it in `android/app/` folder
4. Enable Firebase services:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Firebase Storage
5. Set up Firestore Security Rules (see [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md) for details)
6. Create Firestore Index (click the link in error message)

### 4. Run the Application

```bash
flutter run
```

## 📱 Platform Configuration

### Android

- **Package Name**: `com.akdbt.bupra`
- Minimum SDK: 21
- Target SDK: 34

### iOS

- **Bundle Identifier**: `com.akdbt.bupra` (set in Xcode)
- Minimum iOS: 12.0

## 🏗️ Project Structure

```
lib/
├── main.dart                    # Application entry point
├── models/                      # Data models
│   ├── user_model.dart
│   ├── chat_model.dart
│   └── message_model.dart
├── services/                    # Firebase services
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── storage_service.dart
├── screens/                     # Screens
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── friends_screen.dart
│   ├── chat_screen.dart
│   └── create_group_screen.dart
└── widgets/                     # Widgets
    └── message_bubble.dart
```

## 🔍 Firestore Index

When you first run the app, you may get a Firestore index error. This is normal:

1. Click the blue link in the error message
2. Click "Create Index" in Firebase Console
3. Wait for the index to be created (1-2 minutes)
4. Restart the app when index is "Enabled"

**Index Details:**
- Collection: `chats`
- Fields: `members` (Array) + `updatedAt` (Descending)

## 🔐 Firebase Security Rules

For detailed security rules, see [FIRESTORE_SECURITY_RULES.md](FIRESTORE_SECURITY_RULES.md).

**Important:** Firestore Security Rules must be set up in Firebase Console before the app will work.

## 📊 Data Model

### Users Collection
```
users/{uid}
  - username: string (base username, without #number)
  - displayName: string (full display name, username#number format)
  - email: string
  - photoUrl: string (optional)
```

### Display Names Collection
```
displayNames/{normalizedDisplayName}
  - uid: string
  - displayName: string (username#number)
  - createdAt: timestamp
```

### Friends Collection
```
friends/{uid}/friends/{friendUid}
  - addedAt: timestamp
```

### Chats Collection
```
chats/{chatId}
  - isGroup: boolean
  - name: string (optional, for groups)
  - members: array[string]
  - lastMessage: string (optional)
  - updatedAt: timestamp
```

### Messages Subcollection
```
chats/{chatId}/messages/{messageId}
  - senderId: string
  - text: string (optional)
  - imageUrl: string (optional)
  - createdAt: timestamp
```

## 🛠️ Development

### Code Structure

- **Services**: All Firebase operations are organized in service classes
- **Models**: Type-safe data models with Firestore serialization
- **Screens**: Each screen in its own file
- **Widgets**: Reusable UI components

### Testing

```bash
flutter test
```

## 📝 License

This is a private project.

## 🤝 Contributing

Contributions are welcome! Please test your changes before submitting a pull request.

## 📞 Contact

You can open an issue for questions.

---

**Note**: This application is for educational and development purposes. Review security settings before using in production.


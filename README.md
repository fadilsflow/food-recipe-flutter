# Recipe App

A modern Flutter application for managing and sharing food recipes. This app allows users to create, view, like, and comment on recipes with a beautiful and responsive user interface.

## 📱 Features

- **Authentication System**
  - Secure Login & Registration
  - Token-based authentication
  - Auto-login functionality
- **Recipe Management**

  - Browse a list of recipes in a staggered grid layout
  - View detailed recipe information including ingredients and instructions
  - Create and share your own recipes (with image upload)
  - Edit and delete your recipes

- **Social Interaction**

  - Like recipes
  - Comment on recipes
  - View like counts and user comments

- **Modern UI/UX**
  - Smooth animations using `animate_do` and `flutter_staggered_animations`
  - Custom responsive design
  - Clean and intuitive interface

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **State Management:** [Provider](https://pub.dev/packages/provider)
- **Networking:** [Dio](https://pub.dev/packages/dio)
- **Local Storage:**
  - [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) (for sensitive data like tokens)
  - [shared_preferences](https://pub.dev/packages/shared_preferences) (for user preferences)
- **UI Components:**
  - [google_fonts](https://pub.dev/packages/google_fonts)
  - [image_picker](https://pub.dev/packages/image_picker)
  - [animate_do](https://pub.dev/packages/animate_do)

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.0.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/flutter_storage.git
   cd flutter_storage
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── core/               # Core configurations (Theme, Constants)
├── data/               # Data layer
│   ├── models/         # Data models (Recipe, User, Comment)
│   └── services/       # API services (AuthService, RecipeService)
├── providers/          # State management (AuthProvider, RecipeProvider)
├── screens/            # UI Screens (Home, Detail, Add Recipe, Auth)
└── main.dart           # Application entry point
```

## 🔗 API Integration

This application interacts with the following base API URL:
`https://freeapi.tahuaci.com`

Key endpoints include:

- `/api/login` & `/api/register` for authentication
- `/api/recipe` for fetching and managing recipes
- `/api/comment` for recipe comments

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

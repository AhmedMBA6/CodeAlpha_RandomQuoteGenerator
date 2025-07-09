# 📱 QuoteShot 

A beautiful, accessible, and fully-tested Flutter app for inspirational quotes, built with clean architecture and best practices.

---

## 🎯 Overview

This app fetches and displays random inspirational quotes, allowing users to save favorites, enjoy a responsive and accessible UI, and benefit from robust error handling. The codebase is modular, maintainable, and covered by comprehensive unit and widget tests.

---

## ✨ Features

- 🔁 Get a new random quote on each open or button tap
- 🧠 View quote content and author in a stylized card
- ❤️ Mark/unmark quotes as **favorites**
- 💾 Favorites are saved **locally with SharedPreferences**
- 🌓 Custom splash screen and branded launcher icon
- ⚙️ Structured with **Cubit + Freezed** for state management
- 🧩 Uses **Dio + Retrofit** for networking
- ❌ Handles API and connectivity errors gracefully
- 🎨 Minimal, elegant, and responsive UI

---

## 🔮 Coming Soon

> Future roadmap (planned after internship submission):

- 🧪 CI/CD setup (Firebase-app_distribution,GitHub Actions or Codemagic)
- 🔀 Flavors for Dev & Prod environment configuration
- 🧱 Quote categories (motivational, love, life, etc.)
- 🗂 History screen for previously fetched quotes
- ☁️ Cloud sync for favorites (Firebase)

---

## 📦 Tech Stack

| Layer         | Tools                                |
|---------------|--------------------------------------|
| State Mgmt    | `Cubit`, `Freezed`                   |
| API           | `Dio`, `Retrofit`, `ZenQuotes API`   |
| Storage       | `SharedPreferences`                  |
| UI            | `Shimmer`, `Material 3`, `AnimatedSwitcher` |
| Structure     | Clean Architecture, `get_it` for DI  |

---

## 🗂 Folder Structure

```
lib/
├── main.dart                      # App entry point
├── core/
│   ├── app/                       # Main app widget and configuration
│   ├── config/                    # App configuration, themes, UI constants
│   ├── di/                        # Dependency injection setup
│   ├── error_handler/             # Global error classes and failure handling
│   ├── network/                   # API service clients and constants
│   └── utils/                     # Reusable helpers (SharedPrefsService, etc.)
├── features/
│   ├── quotes/                    # Quotes feature (data, logic, UI)
│   └── favorites/                 # Favorites feature (data, logic, UI)
└── shared/                        # Common widgets and global UI helpers

test/
├── features/
│   ├── quotes/
│   │   ├── data/
│   │   │   ├── models/            # quote_model_test.dart
│   │   │   └── repos/             # quote_repository_test.dart
│   │   └── logic/                 # quote_cubit_test.dart
│   └── favorites/
│       ├── data/                  # favorites_repository_test.dart
│       └── logic/                 # favorites_cubit_test.dart
└── widget_test.dart               # General widget tests
```

---

## 🏆 Accessibility & Responsiveness

- All widgets are responsive using `LayoutBuilder`, `MediaQuery`, and centralized constants.
- Semantics and accessibility labels are provided for screen readers.
- Color contrast and tap targets follow accessibility guidelines.

---

## 🗄️ Persistent Storage & DI

- **SharedPrefsService**: All persistent storage (e.g., first launch, favorites) is handled via a global, injectable service (`lib/core/utils/shared_prefs_service.dart`).
- **Dependency Injection**: All services, repositories, and cubits are registered in `lib/core/di/injection_container.dart` using `get_it`.
- This ensures testability, maintainability, and easy migration if storage needs change.

---

## 🧪 Testing

- **100% unit and widget test coverage** for:
  - Quote fetching, state management, and error handling
  - Favorites logic (add, remove, persist)
  - Repository and model serialization
  - UI widgets (loading, error, quote card, buttons)
- **Test files:**
  - `test/features/quotes/data/models/quote_model_test.dart`
  - `test/features/quotes/data/repos/quote_repository_test.dart`
  - `test/features/quotes/logic/quote_cubit_test.dart`
  - `test/features/favorites/data/favorites_repository_test.dart`
  - `test/features/favorites/logic/favorites_cubit_test.dart`
  - `test/widget_test.dart`
- **Mocking:** Uses `SharedPreferences.setMockInitialValues({})` for local storage tests.
- **How to run tests:**

```bash
flutter test
```

All tests should pass. For coverage reports, use:

```bash
flutter test --coverage
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (preferably via [FVM](https://fvm.app/))
- Git
- Internet connection (for API requests)

### Setup & Run

```bash
fvm flutter pub get
fvm flutter run
```

---

🧑‍💻 Developer
Ahmed Bauiomy
Flutter Developer | CodeAlpha Internship
| com.quoteshot.app

## 🤝 Contribution

Contributions are welcome! Please follow best practices and ensure all tests pass before submitting a PR.

---

## 📷 Screenshots

<div align="center">
<img src="https://github.com/user-attachments/assets/92eb8e9c-12b7-4cf3-80de-093819dbea65" width="200"/>
  <img src="https://github.com/user-attachments/assets/4bc287c4-d35a-4ff4-af2a-b0e7280b730b" width="200"/>
  <img src="https://github.com/user-attachments/assets/7183e176-ccf7-4dac-9fc2-a997b0a9d96a" width="200"/>
  <img src="https://github.com/user-attachments/assets/768afe1a-3676-4e29-843c-2d3c1a3c16f7" width="200"/>
  <img src="https://github.com/user-attachments/assets/57542707-7206-442c-8257-5e81fdb6e489" width="200"/>
  <img src="https://github.com/user-attachments/assets/0d6a2cbb-3fbc-4cb1-8685-f73fb8b71d75" width="200"/>
>

---

## 📄 License

This project is developed as part of the CodeAlpha Internship Program.

---

## 📞 Support

- Create an issue in the repository
- Contact the development team

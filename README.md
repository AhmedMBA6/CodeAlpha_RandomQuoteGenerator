# 📱 CodeAlpha Random Quote Generator App

This is a Flutter-based mobile application built as part of the **CodeAlpha Internship Program**.  
It is designed following **clean architecture principles**, ensuring a scalable, modular, and maintainable codebase.

---

## 🎯 Purpose

- Fetch and display **random inspirational quotes**
- Each quote includes **text** and **author**
- Refresh the displayed quote with a single tap
- Provide a **clean, minimal, and responsive UI**

---

## ✨ Features

- Fetches live quotes from `https://api.quotable.io/random`
- Displays quote content and author
- “New Quote” button to refresh with a new random quote
- Proper loading indicator and error handling
- Designed with **clean architecture**
- Easy to extend with future features (favorites, history)
- Modular folder structure for maintainability

---

## Architecture

This project follows the **Clean Architecture** pattern for Flutter, which separates the codebase into distinct layers:

- **UI**: UI code (widgets, screens, state management)
- **Logic**: Business logic (entities, use cases, repositories - abstract)
- **Data**: Data sources (local, remote, repository implementations)

The folder structure will be organized as follows:

```
lib/
├── core/
│ ├── error_handler/ # Global error classes and failure handling
│ ├── network/ # API service clients and constants
│ └── utils/ # Reusable helpers (formatters, etc.)
│
├── features/
│ └── quotes/
│ ├── data/ # Models, data sources, repository implementation
│ ├── logic/ # State management (Cubit/BLoC, events, states)
│ └── ui/# UI components (screens, widgets)
│
├── shared/ # Common widgets and global UI helpers
└── main.dart # App entry point
```

Each feature and update will be documented here as the project progresses.

---

## 🏗 Folder Responsibilities

| Folder                            | Responsibility                                      |
|----------------------------------|-----------------------------------------------------|
| `core/error_handler/`                    | Define and handle app-wide error and failure cases |
| `core/network/`                  | API endpoints, base URL, and HTTP client config     |
| `core/utils/`                    | Helpers like formatters or extensions               |
| `features/quotes/data/`          | API integration, models, and repository implementation |
| `features/quotes/logic/`   | Business logic layer (Cubit/BLoC and states)        |
| `features/quotes/ui/`  | Screens and UI widgets                              |
| `shared/`                        | Global reusable UI components                       |

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (preferably via [FVM](https://fvm.app/))
- Git and SourceTree (for branch control)
- Internet connection (for API requests)

---

### 🛠 How to Run

```bash
fvm flutter pub get
fvm flutter run

---
*This README will be updated as the project evolves.*
# Flutter TODO App (SQFLite - Local Database)

A simple TODO application built with Flutter using SQFLite for local database storage.  
This project is created for learning how to implement SQLite in Flutter with basic state management using only setState().

---

## Features

- Add new tasks
- Update existing tasks
- Delete tasks
- View all tasks
- Persistent local storage using SQLite
- State management using setState()

---

## Technologies Used

- Flutter
- Dart
- SQFLite
- path_provider
- path

---

## Project Structure

```
lib/
│
├── main.dart
├── repository/database_repository.dart
└── todo_model.dar|
└── constants/
```

---

## Database

- SQLite database stored locally on device
- CRUD operations implemented:
  - Insert
  - Read
  - Update
  - Delete

---

## State Management

This app uses only:

```dart
setState(() {})
```

No Provider, Bloc, Riverpod, or other state management libraries are used.

---
## Screenshots
![Home Screen]Project/Screenshot 2026-03-02 084337.png

## Getting Started

Clone the repository:

```bash
git clone https://github.com/msaadsaleem1001/todo-app.git
```

Navigate to project folder:

```bash
cd flutter-todo-app
```

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

---

## Purpose

This project is created for beginners who want to learn:

- How to use SQFLite in Flutter
- How local databases work
- How CRUD operations are implemented
- How to refresh UI using setState()

---

## Author

Saad Saleem


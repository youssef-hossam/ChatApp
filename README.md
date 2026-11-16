<h1 align="center">💬 Schoolar Chat</h1>

<p align="center">
  A real-time chat app built with <b>Flutter</b> and <b>Firebase</b> — sign up, log in and chat instantly.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/State-Cubit%20%2F%20BLoC-21B18F?style=flat-square" alt="Cubit"/>
</p>

<p align="center">
  <img src="screenshots/hero.webp" alt="Schoolar Chat" width="100%"/>
</p>

## 📱 Screens

| Login | Register error | Chat |
|:-:|:-:|:-:|
| <img src="screenshots/2.webp" width="200"/> | <img src="screenshots/3.webp" width="200"/> | <img src="screenshots/1.webp" width="200"/> |

## ✨ Features

- 🔐 **Register & login** with Firebase Authentication (email + password), with clear error dialogs (e.g. account already exists).
- ⚡ **Real-time messages** streamed from Cloud Firestore — new messages appear instantly.
- 🫧 Separate chat bubbles for **my messages** and **friend messages**, auto-scroll to the latest one.
- ⏳ Loading overlay while signing in, and form validation on every field.

## 🏗️ How it's built

```
lib/
├── cubits/      # AuthCubit + ChatCubit — business logic & states
├── blocs/       # AuthBloc (event-driven version of the same flow)
├── models/      # MessageModel
├── Pages/       # login / register / chat screens
├── widgets/     # reusable text field, button, chat bubbles
└── helper/      # snackbar helper
```

- **State management:** `flutter_bloc` — the UI only listens to states (`loading`, `success`, `failure`).
- **Backend:** `firebase_auth` + `cloud_firestore`.

## 🚀 Run it

```bash
flutter pub get
flutter run
```

> Uses the project's existing Firebase config (`firebase_options.dart`). To use your own Firebase project, run `flutterfire configure`.

---

<p align="center">Made with ❤️ by <a href="https://github.com/youssef-hossam">Youssef Hadwa</a></p>

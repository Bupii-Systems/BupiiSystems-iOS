# Bupii – iOS App

**Bupii** is a mobile application designed to support a chain of beauty salons in Brazil. The project was created to help a relative manage appointments, professionals, and services within their business.

While the interface is in Portuguese (targeting Brazilian users), the entire codebase follows English conventions — including file names, folder structure, and development best practices.

All screens and user experience flows were personally designed with special attention to clarity, usability, and mobile design standards.

## 🛠️ Tech Stack

- **Frameworks**
  - SwiftUI (majority of the codebase)
  - UIKit (used in specific components)
    - `ProfileAndSettingsViewController`
    - `ProfileAndSettingsUIKitView`

- **Unit Testing**
  - XCTest used for key view models
    - `HomeViewModelTests`
    - `MyAgendaViewModelTests`

- **App Security**
  - Reverse engineering protection with [Talsec](https://talsec.app/)
  - Configuration file: `TalsecConfigure`

- **Backend & Database**
  - Firebase Authentication
  - Firebase Firestore for real-time data storage

## ⚠️ Notes

While the app is mostly complete and functional (MVP-ready), some parts of the code may still contain hardcoded values or lack full dynamic behavior, as the project is still under development.

---

**Pedro Santos**

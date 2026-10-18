# First Flutter Project — Shopping App

A Flutter mini project demonstrating separate widgets, responsive layouts, form validation, navigation with fade transitions, and English/Arabic localization.

## Features
- Intro screen with a local asset image and an internet image.
- Responsive shopping page with a PageView, product grid, cart counter, SnackBar, and five hot offers.
- Sign-up form with inline validation.
- Fade transition from Sign Up to Shopping.
- English and Arabic language toggle with right-to-left Arabic layout.
- UI text stored in ARB localization files.

## Requirements
- Flutter SDK and Dart
- VS Code or Android Studio
- Internet connection for Google Fonts and network product photos

## Run
```bash
flutter pub get
flutter gen-l10n
dart format .
flutter run
```

## Screenshots
Create a `screenshots` folder and add screenshots for:
1. Phase 1 terminal commands and Flutter version.
2. Intro screen (local and network images).
3. Shopping screen (PageView, product grid, Add-to-Cart SnackBar, and Hot Offers).
4. Sign-up screen with validation errors.
5. Successful account creation dialog and fade transition.
6. Arabic intro, sign-up, and shopping screens.

## Notes
This is a learning project. The sign-up form validates input locally; it does not create a real user account or store passwords.

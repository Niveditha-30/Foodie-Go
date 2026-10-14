# FoodieGo — Flutter Food Delivery Demo

FoodieGo is a Flutter/Dart demo app featuring:
- Home screen with food categories and offers
- Food search, favorites, and cart
- Food Mood recommendations based on mood, budget, and delivery time
- Demo coupon, payment-method selection, order tracking, and order history
- Light/dark theme toggle
- Food images loaded from remote Unsplash URLs

## Project contents

- `lib/main.dart` — application source code
- `pubspec.yaml` — Flutter package configuration
- `apk/FoodieGo.apk` — provided Android APK for installation/testing

## Create platform folders

This package contains the Dart source and project configuration, but not the generated Android/iOS platform scaffolding. On a computer with Flutter installed, open a terminal in this folder and run:

```bash
flutter create --platforms=android,ios,web .
flutter pub get
flutter analyze
```

Then, to build a release APK:

```bash
flutter build apk --release
```

The generated APK is normally at `build/app/outputs/flutter-apk/app-release.apk`.

## Notes

- The payment and order-tracking flow is a demonstration UI; it does not process real payments or place real restaurant orders.
- Food photos are fetched from remote URLs, so an internet connection is needed to load them.
- The source uses Flutter Material APIs including `Color.withValues`; use a recent Flutter SDK.

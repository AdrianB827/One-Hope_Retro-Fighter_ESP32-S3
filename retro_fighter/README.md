# retro_fighter

Flutter client for One Hope: Retro Fighter.

## Two-phone turn test

1. Connect both phones to the same Wi-Fi network. The network must allow devices to reach each other.
2. Open the app on Android and tap **Host two-phone turn test**. Keep the app in the foreground.
3. On the second phone, open the displayed Wi-Fi address in a browser, including `http://` and the port. Tap **Join as Player 2**.
4. On Android, choose **X-Slash**. The second phone should display “Player 1 selected X-Slash. Your turn.” The Android move buttons stay disabled until Player 2 chooses a move.
5. Select **Crescent Fang** on the second phone and check that Player 1 sees the result and can act again. Tap **End turn test** on Android to release the player slots.

The Android phone hosts this temporary test. It exercises move selection and turn ownership while HP and MP stay at their starting values. The ESP32 integration and damage calculations are separate milestones.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

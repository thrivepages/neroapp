
# Seize the Day — Life Navigator (Launch-ready MVP)

**Local-first. Privacy-first.** Planner, Journal, Mood & Energy, and Mind Board (notes + images).

## Run
```bash
cd seize_the_day
./setup.sh
```

If you prefer manual:
```bash
flutter create .
echo 'android.ndkVersion=27.0.12077973' >> android/gradle.properties
flutter pub get
flutter run -d <deviceId>
```

## Google Play release (Android)
1. Pick a unique package id when creating Android: `flutter create --org com.yourdomain .` (optional now; we can rename later).
2. App icons: replace `android/app/src/main/res/mipmap-*` (use flutter_launcher_icons if you like).
3. Versioning: edit `pubspec.yaml` `version: 1.0.0+1` and `android/app/build.gradle` for versionCode if needed.
4. Build bundle:
   ```bash
   flutter build appbundle --release
   ```
5. App signing: create upload key (or use Play App Signing).
6. Play Console: create app, fill store listing, content rating, privacy policy (local-first), upload `.aab`.
7. Test track → production.

## Apple App Store (iOS)
- Needs a Mac with Xcode, Apple Developer account.
- After `flutter create .`, open `ios/Runner.xcworkspace` in Xcode.
- Set bundle id (e.g., `com.yourdomain.seizetheday`), signing team.
- Build archive in Xcode → upload with Transporter.
- Fill App Store Connect metadata, privacy, screenshots. Submit for review.

## Notes
- Image picking stores copies in the app documents directory.
- Tone setting persists and applies on next launch (font-family placeholder wired for now).
- All data stays local (Hive boxes). No server required.

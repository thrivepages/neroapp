#!/usr/bin/env bash
set -e
echo "=== Seize the Day setup ==="
if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter is not installed or not in PATH."
  exit 1
fi

# Generate platform folders if missing
if [ ! -d "android" ] || [ ! -d "ios" ]; then
  echo "Running: flutter create ."
  flutter create .
fi

# Ensure NDK version to avoid plugin mismatch
echo "android.ndkVersion=27.0.12077973" >> android/gradle.properties

echo "Running: flutter pub get"
flutter pub get

# Try to detect a connected Android device
DEVICE=$(flutter devices | awk '/android-arm|android-x64|android/ {print $3}' | head -n1)
if [ -n "$DEVICE" ]; then
  echo "Launching on $DEVICE ..."
  flutter run -d $DEVICE
else
  echo "No Android device detected. You can run: flutter run -d <deviceId>"
fi
echo "=== Done ==="

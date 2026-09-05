# Absher Clone - Installation Guide

## Quick Start

### For End Users (Installing Pre-built APK)

1. **Download APK**
   - Get `app-release.apk` from GitHub releases or your distribution source

2. **Enable Unknown Sources** (Android Settings)
   - Go to Settings → Security → Unknown Sources → Enable

3. **Install APK**
   - Open the APK file
   - Tap "Install"
   - Wait for installation to complete

4. **Launch App**
   - Find "Absher Clone" in your app drawer
   - Tap to launch

### For Developers (Building from Source)

#### Prerequisites

- Flutter SDK 3.0+ ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Android SDK API 21+ ([Android Studio](https://developer.android.com/studio))
- Java Development Kit (JDK) 8+
- Git

#### Step 1: Clone Repository

```bash
git clone https://github.com/itntravelpoint-source/absher-clone-app.git
cd absher-clone-app/mobile
```

#### Step 2: Install Dependencies

```bash
flutter pub get
```

#### Step 3: Verify Setup

```bash
flutter doctor
```

Fix any issues reported by Flutter Doctor.

#### Step 4: Run Development Build

```bash
# On physical device (connected via USB)
flutter run

# On emulator
flutter emulators --launch <emulator_name>
flutter run
```

#### Step 5: Build Release APK

See [BUILD_AND_RELEASE.md](docs/BUILD_AND_RELEASE.md) for complete instructions.

**Quick build:**

```bash
# Ensure keystore is configured
cp android/key.properties.example android/key.properties
# Edit with your credentials

# Build
flutter build apk --release
```

## Device Installation

### Via Flutter CLI

```bash
# Connect device
flutter devices

# Install APK
flutter install build/app/outputs/flutter-apk/app-release.apk
```

### Via ADB (Android Debug Bridge)

```bash
# Install
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Uninstall
adb uninstall com.absher.clone

# Check installation
adb shell pm list packages | grep absher
```

### Manual Installation

1. Connect device to computer via USB
2. Enable "Developer Mode" on device
3. Copy APK file to device
4. Open file manager and tap APK
5. Tap "Install"

## Emulator Installation

### Setup Emulator

```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Or use Android Studio
# Tools → Device Manager → Create Virtual Device
```

### Install on Emulator

```bash
flutter install build/app/outputs/flutter-apk/app-release.apk
```

## Troubleshooting

### "Device not found"

```bash
# Check USB connection
adb devices

# Enable USB debugging on device
# Settings → Developer Options → USB Debugging → Enable

# Restart ADB
adb kill-server
adb start-server
```

### "Installation failed"

```bash
# Uninstall existing version
adb uninstall com.absher.clone

# Clear cache
adb shell pm clear com.absher.clone

# Reinstall
adb install build/app/outputs/flutter-apk/app-release.apk
```

### "Build error: No Android SDK found"

```bash
# Set Android SDK path
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Verify
flutter doctor
```

### "Gradle build failed"

```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter build apk --release
```

## APK Variants

| File | Size | Use Case |
|------|------|----------|
| `app-debug.apk` | Large | Development/Testing |
| `app-release.apk` | Medium | Direct installation |
| `app-arm64-v8a-release.apk` | ~50MB | 64-bit modern devices |
| `app-armeabi-v7a-release.apk` | ~50MB | 32-bit older devices |
| `app-release.aab` | Varies | Google Play Store |

## Post-Installation

1. **First Launch**
   - Allow permissions when prompted
   - Create account or login
   - Grant necessary device permissions

2. **Enable Features**
   - Biometric authentication (if supported)
   - Push notifications
   - Camera access (for document scanning)

3. **Configuration**
   - Update API endpoint in settings (if needed)
   - Configure language preference
   - Set up 2FA

## Uninstallation

### Via Device

1. Settings → Apps → Absher Clone
2. Tap "Uninstall"
3. Confirm

### Via ADB

```bash
adb uninstall com.absher.clone
```

## Version Check

In-app:
- Settings → About → Version

Via ADB:
```bash
adb shell dumpsys package com.absher.clone | grep versionName
```

## Support

For issues:
1. Check [Troubleshooting](#troubleshooting) section
2. Review [BUILD_AND_RELEASE.md](docs/BUILD_AND_RELEASE.md)
3. Create GitHub Issue with:
   - Device model and Android version
   - APK version
   - Error message
   - Steps to reproduce

## Additional Resources

- [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- [Android Device Developer Options](https://developer.android.com/studio/debug/dev-options)
- [ADB Documentation](https://developer.android.com/studio/command-line/adb)
- [Google Play Store Publishing](https://developer.android.com/studio/publish)

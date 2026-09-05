# Building and Releasing APK - Complete Guide

## Prerequisites

- Flutter SDK 3.0+
- Dart SDK
- Android SDK (API level 21+)
- Java Development Kit (JDK) 8+
- A valid Android keystore file for signing

## Step 1: Update Your App Info

### Update version in `pubspec.yaml`:

```yaml
version: 1.0.0+1  # Major.Minor.Patch+BuildNumber
```

### Update app name and icon in `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="Absher Clone"
    android:icon="@mipmap/ic_launcher">
```

## Step 2: Create a Keystore for Signing

You need a keystore file to sign your APK. Run this command once:

```bash
cd android
keytool -genkey -v -keystore release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

You'll be asked for:
- Keystore password
- Key password
- First and last name
- Organization
- City
- State
- Country code

**Important:** Save your passwords safely! You'll need them for future builds.

## Step 3: Configure Key Properties

1. Create `android/key.properties` file:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=release-key.jks
```

2. **IMPORTANT:** Add `key.properties` to `.gitignore`:

```
# In .gitignore
android/key.properties
android/release-key.jks
```

3. Update `android/app/build.gradle` with signing config (see `build.gradle.updated` file).

## Step 4: Build the APK

### Clean previous builds:

```bash
flutter clean
flutter pub get
```

### Build Debug APK (for testing):

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Build Release APK (for production):

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Build Split APKs (smaller size, recommended):

```bash
flutter build apk --release --split-per-abi
```

Output: Multiple APKs in `build/app/outputs/flutter-apk/`
- `app-armeabi-v7a-release.apk` (32-bit)
- `app-arm64-v8a-release.apk` (64-bit)
- `app-x86_64-release.apk` (Intel x86)

### Build App Bundle for Play Store (recommended):

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Step 5: Test the APK

### On Physical Device:

```bash
# Connect device via USB
flutter devices

# Install APK
flutter install build/app/outputs/flutter-apk/app-release.apk

# Or using adb
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

### On Emulator:

```bash
# Start emulator
flutter emulators --launch <emulator_id>

# Install APK
flutter install build/app/outputs/flutter-apk/app-release.apk
```

## Step 6: Upload to Google Play Store

### First Time Setup:

1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new app
3. Fill in app name, category, and content rating
4. Add app screenshots, description, and privacy policy
5. Set pricing and distribution

### Upload APK:

1. Go to "Release" → "Production"
2. Click "Create new release"
3. Upload `app-release.aab` (Android App Bundle)
4. Add release notes
5. Review and publish

## Step 7: Update Your App

For future updates:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # Increment both version and build number
   ```

2. Rebuild:
   ```bash
   flutter build appbundle --release
   ```

3. Upload new bundle to Play Store

## Troubleshooting

### Build fails with Gradle error:

```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter build apk --release
```

### Keystore password error:

```bash
# Re-check your key.properties file
cat android/key.properties

# Verify keystore file exists
ls -la android/release-key.jks
```

### App not installing:

```bash
# Check device
adb devices

# Uninstall previous version
adb uninstall com.absher.clone

# Install fresh
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Out of memory during build:

Edit `android/gradle.properties`:

```properties
org.gradle.jvmargs=-Xmx4096m
```

## APK Output Summary

| Build Type | Output Location | Use Case |
|---|---|---|
| Debug | `build/app/outputs/flutter-apk/app-debug.apk` | Testing & Development |
| Release | `build/app/outputs/flutter-apk/app-release.apk` | Direct Install |
| Split (arm64) | `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` | Modern Devices |
| Split (armv7) | `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` | Older Devices |
| App Bundle | `build/app/outputs/bundle/release/app-release.aab` | Google Play Store |

## Best Practices

1. **Always test on physical devices** before publishing
2. **Keep your keystore file safe** - losing it means losing app updates
3. **Never commit** `key.properties` or `release-key.jks` to git
4. **Increment version numbers** before each release
5. **Use App Bundle (.aab)** for Play Store, not APK
6. **Test split APKs** on different device architectures
7. **Monitor app crashes** using Firebase Crashlytics

## References

- [Flutter Official: Build and release Android app](https://docs.flutter.dev/deployment/android)
- [Google Play Console](https://play.google.com/console)
- [Android Keystore Documentation](https://developer.android.com/training/articles/keystore)
- [Signing Your Applications](https://developer.android.com/studio/publish/app-signing)

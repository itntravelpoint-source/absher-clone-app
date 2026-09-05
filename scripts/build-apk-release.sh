#!/bin/bash

set -e

echo "🚀 Building Absher Clone Release APK..."
echo "=========================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Flutter found${NC}"
flutter --version

# Navigate to mobile directory
cd mobile || exit 1

echo -e "\n${BLUE}Step 1: Checking keystore...${NC}"
if [ ! -f "android/key.properties" ]; then
    echo -e "${RED}❌ android/key.properties not found${NC}"
    echo -e "${YELLOW}Create it from android/key.properties.example${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Keystore properties found${NC}"

echo -e "\n${BLUE}Step 2: Getting dependencies...${NC}"
flutter pub get
echo -e "${GREEN}✓ Dependencies installed${NC}"

echo -e "\n${BLUE}Step 3: Cleaning previous builds...${NC}"
flutter clean
echo -e "${GREEN}✓ Clean complete${NC}"

echo -e "\n${BLUE}Step 4: Building Debug APK...${NC}"
flutter build apk --debug
echo -e "${GREEN}✓ Debug APK built${NC}"
echo -e "${YELLOW}  Location: build/app/outputs/flutter-apk/app-debug.apk${NC}"

echo -e "\n${BLUE}Step 5: Building Release APK (Standard)...${NC}"
flutter build apk --release
echo -e "${GREEN}✓ Release APK built${NC}"
echo -e "${YELLOW}  Location: build/app/outputs/flutter-apk/app-release.apk${NC}"

echo -e "\n${BLUE}Step 6: Building Release APKs (Split per ABI)...${NC}"
flutter build apk --release --split-per-abi
echo -e "${GREEN}✓ Split APKs built${NC}"
echo -e "${YELLOW}  Location: build/app/outputs/flutter-apk/${NC}"
echo -e "${YELLOW}    - app-armeabi-v7a-release.apk (32-bit)${NC}"
echo -e "${YELLOW}    - app-arm64-v8a-release.apk (64-bit)${NC}"
echo -e "${YELLOW}    - app-x86_64-release.apk (Intel x86)${NC}"

echo -e "\n${BLUE}Step 7: Building App Bundle (for Play Store)...${NC}"
flutter build appbundle --release
echo -e "${GREEN}✓ App Bundle built${NC}"
echo -e "${YELLOW}  Location: build/app/outputs/bundle/release/app-release.aab${NC}"

echo -e "\n${GREEN}==========================================${NC}"
echo -e "${GREEN}✅ All builds completed successfully!${NC}"
echo -e "${GREEN}==========================================${NC}"

echo -e "\n${BLUE}📦 Output Summary:${NC}"
echo -e "${YELLOW}Debug APK:${NC}              build/app/outputs/flutter-apk/app-debug.apk"
echo -e "${YELLOW}Release APK:${NC}            build/app/outputs/flutter-apk/app-release.apk"
echo -e "${YELLOW}Split APKs:${NC}             build/app/outputs/flutter-apk/app-*-release.apk"
echo -e "${YELLOW}App Bundle:${NC}             build/app/outputs/bundle/release/app-release.aab"

echo -e "\n${BLUE}📱 Installation Commands:${NC}"
echo -e "${YELLOW}Install Debug APK:${NC}"
echo -e "  flutter install build/app/outputs/flutter-apk/app-debug.apk"
echo -e "\n${YELLOW}Install Release APK:${NC}"
echo -e "  flutter install build/app/outputs/flutter-apk/app-release.apk"
echo -e "\n${YELLOW}Install via adb:${NC}"
echo -e "  adb install -r build/app/outputs/flutter-apk/app-release.apk"

echo -e "\n${BLUE}🎯 Next Steps:${NC}"
echo -e "${YELLOW}1. Test on physical device${NC}"
echo -e "${YELLOW}2. Upload app-release.aab to Google Play Store${NC}"
echo -e "${YELLOW}3. Monitor app performance and crashes${NC}"

echo -e "\n${BLUE}📖 Documentation:${NC}"
echo -e "${YELLOW}See mobile/docs/BUILD_AND_RELEASE.md for detailed instructions${NC}"

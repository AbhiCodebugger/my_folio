---
name: azure-pipeline-flutter
description: CI/CD for shipperbee_delivery iOS builds via Azure DevOps. Use when modifying azure-pipeline-ios-dev.yml, build config, iOS signing, or Flutter build steps.
---

# Azure Pipeline - Flutter iOS

## Pipeline File
`azure-pipeline-ios-dev.yml` in project root (or `shipperbee_delivery/`)

## Key Steps
1. **FlutterInstall**: channel stable, custom version (e.g. 3.35.7)
2. **Precache**: `flutter precache --ios`
3. **Pub get**: `flutter pub get` in `$(projectDirectory)` (shipperbee_delivery)
4. **CocoaPods**: `cd ios && pod install` (or `pod install --repo-update`)
5. **FlutterBuild**: target ios, releaseMode, entryPoint `lib/main_dev.dart`, buildFlavour `Dev`
6. **Xcode**: archive, export ipa, ad-hoc, manual signing

## Variables
- **iOSVariables** variable group
- **projectDirectory**: shipperbee_delivery
- **puro_team_id**, **APPLE_PROV_PROFILE_UUID**, **APPLE_CERTIFICATE_SIGNING_IDENTITY** for signing

## Caches
- Flutter: `$(HOME)/.pub-cache` keyed by pubspec.lock
- Pods: `shipperbee_delivery/ios/Pods` keyed by Podfile.lock
- Xcode DerivedData: `$(HOME)/Library/Developer/Xcode/DerivedData`

## Signing
- InstallAppleCertificate, InstallAppleProvisioningProfile
- Secure files: distribution cert (.p12), provisioning profile (.mobileprovision)

## Output
- IPA published as `FlutteriOSDev` artifact

import 'package:flutter/foundation.dart';

/// Returns the current [TargetPlatform], or null for web
TargetPlatform? get kCurrentPlatform {
  if (kIsWeb) {
    return null;
  }

  return defaultTargetPlatform;
}

bool get kIsAndroid =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

bool get kIsCupertino => !kIsWeb && (kIsIOS || kIsMacOS);

bool get kIsIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

bool get kIsMacOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;

extension TargetPlatformExtension on TargetPlatform {
  bool get isCupertino =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

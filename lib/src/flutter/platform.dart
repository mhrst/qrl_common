import 'dart:io';

import 'package:flutter/foundation.dart';

bool get kIsAndroid => !kIsWeb && Platform.isAndroid;

bool get kIsIOS => !kIsWeb && Platform.isIOS;

bool get kIsMacOS => !kIsWeb && Platform.isMacOS;

bool get kIsCupertino => !kIsWeb && (kIsIOS || kIsMacOS);

/// Returns the current [TargetPlatform], or null for web or unknown platforms
TargetPlatform? get kCurrentPlatform {
  if (kIsWeb) {
    return null;
  }

  if (Platform.isAndroid) return TargetPlatform.android;
  if (Platform.isFuchsia) return TargetPlatform.fuchsia;
  if (Platform.isIOS) return TargetPlatform.iOS;
  if (Platform.isLinux) return TargetPlatform.linux;
  if (Platform.isMacOS) return TargetPlatform.macOS;
  if (Platform.isWindows) return TargetPlatform.windows;
  // Default to null for unknown platforms
  return null;
}

extension TargetPlatformExtension on TargetPlatform {
  bool get isCupertino =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

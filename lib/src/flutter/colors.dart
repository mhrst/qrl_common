import 'package:flutter/painting.dart';

const kColorCancelGrey = Color(0xFF607D8B);
const kColorConfirmGreen = Color(0xFF00AA33);
const kColorWarnOrange = Color(0xFFFFAA00);
const kColorErrorRed = Color(0xFFFF0033);

extension ContrastColor on Color {
  /// Returns a [Color], either black or white, that contrasts with [color].
  Color get contrast {
    if (computeLuminance() > .33) {
      return const Color(0xFF000000);
    }
    return const Color(0xFFFFFFFF);
  }
}

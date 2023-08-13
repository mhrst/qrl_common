import 'package:flutter/painting.dart';

const kColorCancelGrey = Color(0xFF607D8B);
const kColorConfirmGreen = Color(0xFF00AA33);
const kColorWarnOrange = Color(0xFFFFAA00);
const kColorErrorRed = Color(0xFFFF0033);
const kColorBlack = Color(0xFF000000);
const kColorWhite = Color(0xFFFFFFFF);

/// Because [Color.computeLuminance] is expensive, we cache the results.
final _kContrastColorMap = <Color, Color>{};

extension ContrastColor on Color {
  /// Returns a constrasting [Color], either black or white
  Color get contrast => _kContrastColorMap.putIfAbsent(
        this,
        () => computeLuminance() > .33 ? kColorBlack : kColorWhite,
      );
}

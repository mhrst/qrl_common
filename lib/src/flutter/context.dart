import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  Brightness get brightness => theme.brightness;
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  ThemeData get theme => Theme.of(this);
}

/// https://stackoverflow.com/questions/50316219/how-to-get-widgets-absolute-coordinates-on-a-screen-in-flutter
extension GlobalPaintBounds on BuildContext {
  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

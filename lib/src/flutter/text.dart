import 'package:flutter/widgets.dart';

TextPainter textPainterForStyle(BuildContext context, TextStyle? style) =>
    TextPainter(
      text: TextSpan(
        text: ' ',
        style: style,
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: 12.0);

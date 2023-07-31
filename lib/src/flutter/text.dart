import 'package:flutter/widgets.dart';

TextPainter textPainterForStyle(BuildContext context, TextStyle? style) =>
    TextPainter(
      text: TextSpan(
        text: ' ',
        style: style,
      ),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout(maxWidth: 12.0);

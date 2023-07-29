import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qrl_common/flutter.dart';

void main() {
  test('ContrastColor returns black or white', () {
    expect(Colors.black.contrast, equals(Colors.white));
    expect(Colors.white.contrast, equals(Colors.black));
    expect(Colors.grey.contrast, equals(Colors.black));
  });
}

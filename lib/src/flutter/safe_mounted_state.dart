import 'package:flutter/widgets.dart';

/// Implementation of [State] that skips calling [setState] if the widget is
/// not mounted. Prevents errors in cases where the widget is disposed before
/// the state is updated.
abstract class SafeMountedState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      fn();
    } else {
      super.setState(fn);
    }
  }
}

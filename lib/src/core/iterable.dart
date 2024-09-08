extension IterableExtensions<E> on Iterable<E> {
  E? get firstOrNull {
    if (isNotEmpty) {
      return first;
    }

    return null;
  }

  E? get lastOrNull {
    if (isNotEmpty) {
      return last;
    }

    return null;
  }

  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? lastWhereOrNull(bool Function(E) test) {
    for (final element in toList().reversed) {
      if (test(element)) return element;
    }
    return null;
  }
}

T tryCast<T>(Object value, T defaultValue) {
  try {
    return value as T;
  } catch (_) {
    return defaultValue;
  }
}

T? tryCastNullable<T>(Object? value) {
  try {
    return value as T;
  } catch (_) {
    return null;
  }
}

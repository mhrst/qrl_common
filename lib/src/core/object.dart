extension SafeCast on Object? {
  T? as<T extends Object?>() {
    var self = this;
    return self is T ? self : null;
  }
}

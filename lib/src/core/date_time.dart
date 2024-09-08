extension DateTimeExtensions on DateTime {
  static double get epochTimestamp =>
      DateTime.fromMillisecondsSinceEpoch(0).toUtc().timestamp;
  static double get nowTimestamp => DateTime.now().toUtc().timestamp;

  double get timestamp => millisecondsSinceEpoch / 1000;

  bool isSameDayAs(DateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  bool isSameYearAs(DateTime dateTime) {
    return year == dateTime.year;
  }

  static DateTime fromTimestamp(double timestamp) =>
      DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).round(),
          isUtc: true);
}

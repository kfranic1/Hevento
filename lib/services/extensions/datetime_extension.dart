extension DateTimeExtension on DateTime {
  bool sameDay(DateTime other) {
    return trim() == other.trim();
  }

  DateTime trim() {
    return DateTime(year, month, day);
  }
}

class DateTimeConverter {
  static double fromDateTimeToDouble(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch.toDouble() / 1000;
  }

  static DateTime fromDoubleToDateTime(dynamic dateNumber) {
    if (dateNumber != null && dateNumber != 0) {
      double millisecondsSinceEpoch = dateNumber * 1000;
      return DateTime.fromMillisecondsSinceEpoch(
          millisecondsSinceEpoch.round());
    } else {
      return null;
    }
  }
}

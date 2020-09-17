import 'package:intl/intl.dart';

String getOnlyDateString(DateTime dateTime) {
  var formatter = new DateFormat('EEEE, dd/MM/yyyy');
  return formatter.format(dateTime);
}

String getDateAndTimeString(DateTime dateTime) {
  var formatter = new DateFormat('EEEE, dd/MM/yyy, HH:mm');
  return formatter.format(dateTime);
}

String getCurrMonthYear(DateTime dateTime) {
  return '${DateFormat('MMMM').format(dateTime)}, ${dateTime.year} ';
}

import 'package:intl/intl.dart';

String getOnlyDateString(DateTime dateTime) {
  var formatter = new DateFormat('EEEE, dd/MM/yyyy');
  return formatter.format(dateTime);
}

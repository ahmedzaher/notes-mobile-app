import 'package:intl/intl.dart';

formatDate(DateTime date) {
  return new DateFormat('yyyy-MM-dd hh:mm').format(date);;
}
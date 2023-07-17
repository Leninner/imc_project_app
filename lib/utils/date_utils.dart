import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final formatter = DateFormat('dd-MM-yyyy');

  return formatter.format(dateTime);
}

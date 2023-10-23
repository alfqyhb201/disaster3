import 'package:intl/intl.dart';

class DateTimeFunctions {
  String formatDateTimeNow() {
    return DateFormat('y/M/d HH:mm a').format(DateTime.now());
  }

  String formatDateNow() {
    return DateFormat('y/M/d').format(DateTime.now());
  }

  int dateDifference(String dateString) {
    final date = DateFormat('y/M/d').parse(dateString);
    return DateTime.now().difference(date).inDays;
  }

  int getDateInMonth(String dateString) {
    final date = DateFormat('y/M/d').parse(dateString);
    return date.day;
  }

  convertDateToDay(DateTime dateTime) {
    final date = DateFormat('EEEE').format(dateTime);
    return date;
  }
}

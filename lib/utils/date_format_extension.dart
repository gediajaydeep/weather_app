import 'package:intl/intl.dart';

extension DateTimeFormatExt on DateTime {
  String getFormattedDate(String format) {
    try {
      return DateFormat(format).format(this);
    } catch (e) {
      return 'Not Available';
    }
  }
}

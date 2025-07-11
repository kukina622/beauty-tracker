import 'package:intl/intl.dart';

String? tryFormatDate(DateTime? date) {
  if (date == null) {
    return null;
  }

  try {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  } catch (e) {
    return null;
  }
}

DateTime getMonthsAgoFirstDay(int monthsAgo) {
  final DateTime now = DateTime.now();
  int targetMonth = now.month - monthsAgo;
  int targetYear = now.year;

  while (targetMonth <= 0) {
    targetMonth += 12;
    targetYear -= 1;
  }

  return DateTime(targetYear, targetMonth, 1);
}

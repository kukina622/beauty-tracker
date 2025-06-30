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

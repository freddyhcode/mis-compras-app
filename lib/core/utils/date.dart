import 'package:intl/intl.dart';

String toIsoDate(DateTime value) {
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '${value.year}-$month-$day';
}

DateTime? parseIsoDate(String value) {
  final parts = value.split('-');
  if (parts.length != 3) return null;

  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);
  if (year == null || month == null || day == null) return null;

  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) {
    return null;
  }

  return date;
}

String todayIsoDate() {
  return toIsoDate(DateTime.now());
}

String formatDate(DateTime value, String localeName) {
  return DateFormat.yMd(localeName).format(value);
}

String formatDateTime(DateTime value, String localeName) {
  return DateFormat.yMd(localeName).add_Hm().format(value.toLocal());
}

String formatIsoDate(String isoDate, String localeName) {
  final date = parseIsoDate(isoDate);
  if (date == null) return isoDate;
  return formatDate(date, localeName);
}

List<String> lastMonthKeys(int count, {DateTime? from}) {
  final keys = <String>[];
  var cursor = DateTime(
    from?.year ?? DateTime.now().year,
    from?.month ?? DateTime.now().month,
  );

  for (var index = 0; index < count; index++) {
    keys.add(_monthKey(cursor));
    cursor = DateTime(cursor.year, cursor.month - 1);
  }

  return keys.reversed.toList();
}

List<String> yearMonthKeys(int year) {
  return List.generate(12, (index) {
    final month = (index + 1).toString().padLeft(2, '0');
    return '$year-$month';
  });
}

String monthKey(String isoDate) {
  if (isoDate.length < 7) return isoDate;
  return isoDate.substring(0, 7);
}

String monthLabel(String key, String languageCode) {
  final parts = key.split('-');
  if (parts.length != 2) return key;

  final year = parts[0];
  final month = int.tryParse(parts[1]);
  if (month == null || month < 1 || month > 12) return key;

  final name = DateFormat.MMMM(languageCode).format(DateTime(2000, month));
  final label = name.isEmpty
      ? name
      : '${name[0].toUpperCase()}${name.substring(1)}';

  return '$label $year';
}

String _monthKey(DateTime value) {
  final month = value.month.toString().padLeft(2, '0');
  return '${value.year}-$month';
}

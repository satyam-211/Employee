class CalendarHelper {
  static const today = 'Today';
  static const nextMonday = 'Next Monday';
  static const nextTuesday = 'Next Tuesday';
  static const after1Week = 'After 1 Week';

  final DateTime dateTime;
  late final Map<DateTime, String> dateMap;
  late final Map<String, DateTime> reverseDateMap;

  CalendarHelper({required this.dateTime}) {
    dateMap = {};
    dateMap[dateTime] = today;
    final nextMondayDate = dateTime.add(Duration(days: 8 - dateTime.weekday));
    dateMap[nextMondayDate] = nextMonday;
    dateMap[nextMondayDate.add(const Duration(days: 1))] = nextTuesday;
    dateMap[dateTime.add(const Duration(days: 7))] = after1Week;
    reverseDateMap = dateMap.map((key, value) => MapEntry(value, key));
  }
}

extension TimeComponentRemover on DateTime {
  DateTime get onlyDate => DateTime(year, month, day);
}

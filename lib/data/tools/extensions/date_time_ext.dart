import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get greeting {
    final time = hour;
    if (time >= 5 && time <= 10) {
      return "good_morning";
    } else if (time >= 10 && time <= 17) {
      return "good_afternoon";
    }
    return "good_evening";
  }

  String get currentTime => '$hour : $minute : $second';

  String get nextLessonTime => DateFormat('dd - MMM, EE, HH:mm').format(this);

  String get schoolDays => DateFormat('EEEE - HH : mm').format(this);

  String get battleTime => DateFormat('dd.MM.yyy   HH : mm').format(this);
}

extension DurationExt on Duration {
  String get day => '$inDays';

  String get hour => '${inHours - inDays * 24}';

  String get minute => '${inMinutes - inHours * 60}';

  String get second => '${inSeconds - inMinutes * 60}';
}

// ignore_for_file: constant_identifier_names

enum FileType {
  Books,
  Audio,
  Videos,
  Movies,
  Podcasts,
  Cartoons;

  String toJson() => name;

  static FileType fromJson(String json) => values.byName(json);
}

import 'package:json_annotation/json_annotation.dart';

part 'project_data.g.dart';

@JsonSerializable()
class ProjectData {

  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'picture')
  String? picture;
  @JsonKey(name: 'url')
  String? url;


  ProjectData({this.name, this.description,this.picture,this.url});

  Map<String, dynamic> toJson() => _$ProjectDataToJson(this);

  factory ProjectData.fromJson(Map<String, dynamic> json) => _$ProjectDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/all_project/project_data.dart';

part 'all_project_response.g.dart';

@JsonSerializable(createFactory: true)

class AllProjectResponse {
  String? status;
  @JsonKey(name: 'data')
  List<ProjectData>? data;

  AllProjectResponse({this.status, this.data});

  Map<String, dynamic> toJson() => _$AllProjectResponseToJson(this);

  factory AllProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$AllProjectResponseFromJson(json);

  @override
  String toString() => toJson().toString();

}

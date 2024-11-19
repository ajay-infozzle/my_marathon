import 'package:json_annotation/json_annotation.dart';
part 'refer_project_response.g.dart';

@JsonSerializable(createFactory: true)
class ReferProjectResponse{
  List<String>? data;
  String? status;

  ReferProjectResponse({this.data, this.status});

  Map<String,dynamic> toJson() => _$ReferProjectResponseToJson(this);

  factory ReferProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferProjectResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

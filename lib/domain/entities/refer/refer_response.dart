import 'package:freezed_annotation/freezed_annotation.dart';

part 'refer_response.g.dart';

@JsonSerializable(createFactory: true)
class ReferResponse {
  String? attempt;
  String? id;
  String? request_id;
  String? status;

  ReferResponse({this.attempt, this.id, this.request_id, this.status});

  Map<String, dynamic> toJson() => _$ReferResponseToJson(this);

  factory ReferResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

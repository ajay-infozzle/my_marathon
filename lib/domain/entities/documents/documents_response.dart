import 'package:json_annotation/json_annotation.dart';

import 'package:marathon/domain/entities/documents/documents_data.dart';

part 'documents_response.g.dart';

@JsonSerializable()
class DocumentsResponse {
  DocumentsData? data;
  String? message;
  String? status;

  DocumentsResponse({this.data, this.message, this.status});

  Map<String, dynamic> toJson() => _$DocumentsResponseToJson(this);

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentsResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

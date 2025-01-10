import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/document_post/document_post.dart';


part 'post_document_response.g.dart';
@JsonSerializable()
class PostDocumentResponse{
  String? message;
  String? status;
  Map<dynamic,DocumentsPost>? data;

  PostDocumentResponse({this.status,this.data,this.message});

  Map<String, dynamic> toJson() => _$PostDocumentResponseToJson(this);

  factory PostDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$PostDocumentResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}


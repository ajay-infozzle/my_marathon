import 'package:json_annotation/json_annotation.dart';

part 'document_post.g.dart';

@JsonSerializable()
class DocumentsPost {
  String? filename;
  String? link;
  @JsonKey(name: 'apartment_id')
  int? apartmentId;
  String? type;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;

  DocumentsPost({this.filename, this.link, this.apartmentId, this.type,
      this.userId, this.updatedAt, this.createdAt, this.id, this.custId});

  int? id;
  @JsonKey(name: 'cust_id')
  int? custId;

  Map<String, dynamic> toJson() => _$DocumentsPostToJson(this);

  factory DocumentsPost.fromJson(Map<String, dynamic> json) =>
      _$DocumentsPostFromJson(json);

  @override
  String toString() => toJson().toString();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsPost _$DocumentsPostFromJson(Map<String, dynamic> json) =>
    DocumentsPost(
      filename: json['filename'] as String?,
      link: json['link'] as String?,
      apartmentId: json['apartment_id'] as int?,
      type: json['type'] as String?,
      userId: json['user_id'] as int?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
      custId: json['cust_id'] as int?,
    );

Map<String, dynamic> _$DocumentsPostToJson(DocumentsPost instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'link': instance.link,
      'apartment_id': instance.apartmentId,
      'type': instance.type,
      'user_id': instance.userId,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
      'cust_id': instance.custId,
    };

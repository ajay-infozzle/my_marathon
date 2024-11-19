// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_document_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDocumentResponse _$PostDocumentResponseFromJson(
        Map<String, dynamic> json) =>
    PostDocumentResponse(
      status: json['status'] as String?,
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, DocumentsPost.fromJson(e as Map<String, dynamic>)),
      ),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PostDocumentResponseToJson(
        PostDocumentResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

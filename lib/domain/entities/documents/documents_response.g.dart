// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsResponse _$DocumentsResponseFromJson(Map<String, dynamic> json) =>
    DocumentsResponse(
      data: json['data'] == null
          ? null
          : DocumentsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DocumentsResponseToJson(DocumentsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };

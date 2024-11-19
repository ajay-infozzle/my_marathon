// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refer_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferProjectResponse _$ReferProjectResponseFromJson(
        Map<String, dynamic> json) =>
    ReferProjectResponse(
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ReferProjectResponseToJson(
        ReferProjectResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

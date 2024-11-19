// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllProjectResponse _$AllProjectResponseFromJson(Map<String, dynamic> json) =>
    AllProjectResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProjectData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllProjectResponseToJson(AllProjectResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

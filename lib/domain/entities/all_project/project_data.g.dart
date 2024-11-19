// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectData _$ProjectDataFromJson(Map<String, dynamic> json) => ProjectData(
      name: json['name'] as String?,
      description: json['description'] as String?,
      picture: json['picture'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ProjectDataToJson(ProjectData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'picture': instance.picture,
      'url': instance.url,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferResponse _$ReferResponseFromJson(Map<String, dynamic> json) =>
    ReferResponse(
      attempt: json['attempt'] as String?,
      id: json['id'] as String?,
      request_id: json['request_id'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ReferResponseToJson(ReferResponse instance) =>
    <String, dynamic>{
      'attempt': instance.attempt,
      'id': instance.id,
      'request_id': instance.request_id,
      'status': instance.status,
    };

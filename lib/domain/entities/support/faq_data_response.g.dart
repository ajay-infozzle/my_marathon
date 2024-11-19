// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqDataResponse _$FaqDataResponseFromJson(Map<String, dynamic> json) =>
    FaqDataResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FaqData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$FaqDataResponseToJson(FaqDataResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

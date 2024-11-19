// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartments_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentsList _$ApartmentsListFromJson(Map<String, dynamic> json) =>
    ApartmentsList(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : ApartmentsListData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApartmentsListToJson(ApartmentsList instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

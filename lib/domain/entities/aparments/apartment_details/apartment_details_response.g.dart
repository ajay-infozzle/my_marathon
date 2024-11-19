// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentDetailsResponse _$ApartmentDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ApartmentDetailsResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : ApartmentDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApartmentDetailsResponseToJson(
        ApartmentDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      status: json['apartment_id'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PaymentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'apartment_id': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

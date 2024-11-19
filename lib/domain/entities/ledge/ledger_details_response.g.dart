// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerDetailsResponse _$LedgerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    LedgerDetailsResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : LedgerDetails.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LedgerDetailsResponseToJson(
        LedgerDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

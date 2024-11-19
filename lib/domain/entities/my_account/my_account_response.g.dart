// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAccountResponse _$MyAccountResponseFromJson(Map<String, dynamic> json) =>
    MyAccountResponse(
      data: json['data'] == null
          ? null
          : MyAccountData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MyAccountResponseToJson(MyAccountResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

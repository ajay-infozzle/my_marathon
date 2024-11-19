// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String?,
      email: json['email'] as String?,
      userId: json['user_id'] as int?,
      custId: json['cust_id'] as int?,
      mobile: json['mobile'] as String?,
      verified: json['verified'] as bool?,
      otp: json['otp'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
      'otp': instance.otp,
      'verified': instance.verified,
      'cust_id': instance.custId,
    };

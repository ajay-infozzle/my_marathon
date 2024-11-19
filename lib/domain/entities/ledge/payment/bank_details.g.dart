// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) => BankDetails(
      name: json['name'] as String?,
      address: json['address'] as String?,
      branch: json['branch'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      accName: json['acc_name'] as String?,
      acNo: json['ac_no'] as String?,
    );

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'branch': instance.branch,
      'ifsc_code': instance.ifscCode,
      'acc_name': instance.accName,
      'ac_no': instance.acNo,
    };

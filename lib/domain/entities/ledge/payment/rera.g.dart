// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rera.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rera _$ReraFromJson(Map<String, dynamic> json) => Rera(
      building: json['building'] as String?,
      project: json['project'] as String?,
      reraRegNo: json['rera_reg_no'] as String?,
      bankDetails: json['bank_details'] == null
          ? null
          : BankDetails.fromJson(json['bank_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReraToJson(Rera instance) => <String, dynamic>{
      'building': instance.building,
      'project': instance.project,
      'rera_reg_no': instance.reraRegNo,
      'bank_details': instance.bankDetails,
    };

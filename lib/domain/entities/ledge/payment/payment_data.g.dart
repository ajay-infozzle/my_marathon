// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) => PaymentData(
      rera: json['rera'] == null
          ? null
          : Rera.fromJson(json['rera'] as Map<String, dynamic>),
      dueAmount: json['due_amount'] as String?,
      apartmentId: json['apartment_id'] as int?,
      milestoneId: json['milestone_id'] as String?,
    );

Map<String, dynamic> _$PaymentDataToJson(PaymentData instance) =>
    <String, dynamic>{
      'apartment_id': instance.apartmentId,
      'milestone_id': instance.milestoneId,
      'due_amount': instance.dueAmount,
      'rera': instance.rera,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerDetails _$LedgerDetailsFromJson(Map<String, dynamic> json) =>
    LedgerDetails(
      aptId: json['apt_id'] as int?,
      milestones: (json['milestones'] as List<dynamic>?)
          ?.map((e) => Milestone.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalOutstanding: json['totalOutstanding'] as String?,
      details: json['details'] == null
          ? null
          : ApartmentDetails.fromJson(json['details'] as Map<String, dynamic>),
      demandLetterRouteData: json['demandLetterRouteData'],
    );

Map<String, dynamic> _$LedgerDetailsToJson(LedgerDetails instance) =>
    <String, dynamic>{
      'apt_id': instance.aptId,
      'milestones': instance.milestones,
      'details': instance.details,
      'demandLetterRouteData': instance.demandLetterRouteData,
      'totalOutstanding': instance.totalOutstanding,
    };

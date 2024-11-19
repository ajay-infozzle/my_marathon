// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand_letter_route_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemandLetterRouteData _$DemandLetterRouteDataFromJson(
        Map<String, dynamic> json) =>
    DemandLetterRouteData(
      apartmentId: json['apartment_id'] as int?,
      milestoneId: json['milestone_id'] as String?,
      milestoneData: json['milestone_data'] as String?,
    );

Map<String, dynamic> _$DemandLetterRouteDataToJson(
        DemandLetterRouteData instance) =>
    <String, dynamic>{
      'apartment_id': instance.apartmentId,
      'milestone_id': instance.milestoneId,
      'milestone_data': instance.milestoneData,
    };

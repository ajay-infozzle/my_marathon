// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartments_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentsListData _$ApartmentsListDataFromJson(Map<String, dynamic> json) =>
    ApartmentsListData(
      apartments: (json['apartments'] as List<dynamic>?)
          ?.map((e) => Apartment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApartmentsListDataToJson(ApartmentsListData instance) =>
    <String, dynamic>{
      'apartments': instance.apartments,
    };

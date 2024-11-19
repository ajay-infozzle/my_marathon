// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apartment _$ApartmentFromJson(Map<String, dynamic> json) => Apartment(
      apartmentId: json['apartment_id'] as String?,
      project: json['project'] as String?,
      building: json['building'] as String?,
      custId: json['cust_id'] as int?,
      title: json['title'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$ApartmentToJson(Apartment instance) => <String, dynamic>{
      'apartment_id': instance.apartmentId,
      'project': instance.project,
      'building': instance.building,
      'title': instance.title,
      'img': instance.img,
      'cust_id': instance.custId,
    };

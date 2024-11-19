// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_details_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApartmentDetailsData _$ApartmentDetailsDataFromJson(
        Map<String, dynamic> json) =>
    ApartmentDetailsData(
      apartmentDetails: (json['apartment_details'] as List<dynamic>?)
          ?.map((e) => ApartmentDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      milestones: (json['milestones'] as List<dynamic>?)
          ?.map((e) => Milestone.fromJson(e as Map<String, dynamic>))
          .toList(),
      last: json['last'] == null
          ? null
          : Last.fromJson(json['last'] as Map<String, dynamic>),
      due: json['due'] == null
          ? null
          : Last.fromJson(json['due'] as Map<String, dynamic>),
      next: json['next'] == null
          ? null
          : Last.fromJson(json['next'] as Map<String, dynamic>),
      img: json['img'] as String?,
      statusLink: json['status_link'] as String?,
      mainSiteNews: (json['main_site_news'] as List<dynamic>?)
          ?.map((e) => MainSiteNews.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..constructionLink = json['сonstruction_link'] as String?
      ..constructionImage = json['сonstruction_image'] as String?;

Map<String, dynamic> _$ApartmentDetailsDataToJson(
        ApartmentDetailsData instance) =>
    <String, dynamic>{
      'apartment_details': instance.apartmentDetails,
      'milestones': instance.milestones,
      'last': instance.last,
      'due': instance.due,
      'next': instance.next,
      'img': instance.img,
      'status_link': instance.statusLink,
      'main_site_news': instance.mainSiteNews,
      'сonstruction_link': instance.constructionLink,
      'сonstruction_image': instance.constructionImage,
    };

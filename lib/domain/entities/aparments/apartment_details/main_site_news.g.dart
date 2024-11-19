// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_site_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainSiteNews _$MainSiteNewsFromJson(Map<String, dynamic> json) => MainSiteNews(
      id: json['id'] as int?,
      postId: json['post_id'] as int?,
      link: json['link'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$MainSiteNewsToJson(MainSiteNews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

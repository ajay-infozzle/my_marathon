import 'package:json_annotation/json_annotation.dart';

part 'main_site_news.g.dart';

@JsonSerializable()
class MainSiteNews {

  int? id;
  @JsonKey(name: 'post_id')
  int? postId;
  String? title;
  String? link;
  String? image;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;


  MainSiteNews({this.id,this.postId, this.link,this.image,this.title,this.updatedAt,this.createdAt});

  Map<String, dynamic> toJson() => _$MainSiteNewsToJson(this);

  factory MainSiteNews.fromJson(Map<String, dynamic> json) =>
      _$MainSiteNewsFromJson(json);

  @override
  String toString() => toJson().toString();
}

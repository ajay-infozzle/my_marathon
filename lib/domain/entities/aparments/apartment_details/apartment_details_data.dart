import 'package:json_annotation/json_annotation.dart';
import 'apartment_details.dart';
import 'last.dart';
import 'main_site_news.dart';
import 'milestone.dart';

part 'apartment_details_data.g.dart';

@JsonSerializable(createFactory: true)
class ApartmentDetailsData {
  @JsonKey(name: 'apartment_details')
  List<ApartmentDetails>? apartmentDetails;
  List<Milestone>? milestones;
  Last? last;
  Last? due;
  Last? next;
  String? img;
  @JsonKey(name: 'status_link')
  String? statusLink;
  @JsonKey(name: 'main_site_news')
  List<MainSiteNews>? mainSiteNews;
  @JsonKey(name: 'сonstruction_link')
  String? constructionLink;
  @JsonKey(name: 'сonstruction_image')
  String? constructionImage;


  ApartmentDetailsData({this.apartmentDetails, this.milestones, this.last,
      this.due, this.next, this.img, this.statusLink, this.mainSiteNews});

  Map<String, dynamic> toJson() => _$ApartmentDetailsDataToJson(this);

  factory ApartmentDetailsData.fromJson(Map<String, dynamic> json) =>
      _$ApartmentDetailsDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

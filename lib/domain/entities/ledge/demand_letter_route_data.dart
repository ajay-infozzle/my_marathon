import 'package:json_annotation/json_annotation.dart';

part 'demand_letter_route_data.g.dart';

@JsonSerializable()
class DemandLetterRouteData {
  @JsonKey(name: 'apartment_id')
  int? apartmentId;
  @JsonKey(name: 'milestone_id')
  String? milestoneId;
  @JsonKey(name: 'milestone_data')
  String? milestoneData;


  DemandLetterRouteData({this.apartmentId,this.milestoneId, this.milestoneData});

  Map<String, dynamic> toJson() => _$DemandLetterRouteDataToJson(this);

  factory DemandLetterRouteData.fromJson(Map<String, dynamic> json) =>
      _$DemandLetterRouteDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

import 'package:json_annotation/json_annotation.dart';

part 'apartment.g.dart';

@JsonSerializable()
class Apartment {



  @JsonKey(name: 'apartment_id')
  String? apartmentId;
  String? project;
  String? building;
  String? title;
  String? img;
  @JsonKey(name: 'cust_id')
  int? custId;

  Apartment({this.apartmentId,this.project, this.building,this.custId,this.title,this.img,});

  Map<String, dynamic> toJson() => _$ApartmentToJson(this);

  factory Apartment.fromJson(Map<String, dynamic> json) =>
      _$ApartmentFromJson(json);

  @override
  String toString() => toJson().toString();
}

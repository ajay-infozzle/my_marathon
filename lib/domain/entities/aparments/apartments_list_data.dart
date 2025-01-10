import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/aparments/apartment.dart';

part 'apartments_list_data.g.dart';
@JsonSerializable()
class ApartmentsListData {

  List<Apartment>? apartments;

  ApartmentsListData({this.apartments});

  Map<String, dynamic> toJson() => _$ApartmentsListDataToJson(this);

  factory ApartmentsListData.fromJson(Map<String, dynamic> json) =>
      _$ApartmentsListDataFromJson(json);

  @override
  String toString() => toJson().toString();
}


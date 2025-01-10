import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/aparments/apartments_list_data.dart';

part 'apartments_list.g.dart';

@JsonSerializable()
class ApartmentsList{
  String? message;
  String? status;
  ApartmentsListData? data;

  ApartmentsList({this.status,this.data,this.message});

  Map<String, dynamic> toJson() => _$ApartmentsListToJson(this);

  factory ApartmentsList.fromJson(Map<String, dynamic> json) =>
      _$ApartmentsListFromJson(json);

  @override
  String toString() => toJson().toString();
}


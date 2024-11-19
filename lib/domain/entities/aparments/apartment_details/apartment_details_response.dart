import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/aparments/apartment.dart';
import 'package:marathon/domain/entities/aparments/apartment_details/apartment_details_data.dart';
import 'package:marathon/domain/entities/aparments/apartments_list_data.dart';

part 'apartment_details_response.g.dart';

@JsonSerializable()
class ApartmentDetailsResponse{
  String? message;
  String? status;
  ApartmentDetailsData? data;

  ApartmentDetailsResponse({this.status,this.data,this.message});

  Map<String, dynamic> toJson() => _$ApartmentDetailsResponseToJson(this);

  factory ApartmentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApartmentDetailsResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}


import 'package:json_annotation/json_annotation.dart';


part 'original_data.g.dart';

@JsonSerializable()
class OriginalData{
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;


  OriginalData({this.status, this.message});

  Map<String, dynamic> toJson() => _$OriginalDataToJson(this);

  factory OriginalData.fromJson(Map<String, dynamic> json) =>
      _$OriginalDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

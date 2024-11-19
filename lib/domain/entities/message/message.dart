import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class MessageData {
  String? status;
  String? message;
  Map? data;

  MessageData({this.status, this.data, this.message});

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

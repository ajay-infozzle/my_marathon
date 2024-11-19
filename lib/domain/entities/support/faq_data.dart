import 'package:json_annotation/json_annotation.dart';

part 'faq_data.g.dart';

@JsonSerializable()
class FaqData {
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'question')
  String? question;
  @JsonKey(name: 'answer')
  String? answer;

  FaqData({this.category, this.question, this.answer});

  Map<String, dynamic> toJson() => _$FaqDataToJson(this);

  factory FaqData.fromJson(Map<String, dynamic> json) =>
      _$FaqDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

import 'package:json_annotation/json_annotation.dart';
import 'faq_data.dart';

part 'faq_data_response.g.dart';

@JsonSerializable(createFactory: true)
class FaqDataResponse {
  List<FaqData>? data;
  String? status;

  FaqDataResponse({this.data, this.status});

  Map<String,dynamic> toJson() => _$FaqDataResponseToJson(this);

  factory FaqDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqDataResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

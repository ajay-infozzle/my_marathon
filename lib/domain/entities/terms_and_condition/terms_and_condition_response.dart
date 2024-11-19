import 'package:json_annotation/json_annotation.dart';
part 'terms_and_condition_response.g.dart';

@JsonSerializable(createFactory: true)

class TermsAndConditionResponse{
  String? content;

  TermsAndConditionResponse({this.content,});

  Map<String,dynamic> toJson() => _$TermsAndConditionResponseToJson(this);

  factory TermsAndConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$TermsAndConditionResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

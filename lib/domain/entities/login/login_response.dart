import 'package:json_annotation/json_annotation.dart';
import 'login_data.dart';
part 'login_response.g.dart';

@JsonSerializable()

class LoginResponse {
  String? message;
  String? status;
  Data? data;

  LoginResponse({this.status, this.data, this.message});

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  String toString() => toJson().toString();

}

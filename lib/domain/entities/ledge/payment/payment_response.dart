import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/ledge/payment/payment_data.dart';


part 'payment_response.g.dart';

@JsonSerializable()
class PaymentResponse {



  @JsonKey(name: 'apartment_id')

 String? status;
  String? message;
  PaymentData? data;

  PaymentResponse({this.status, this.message, this.data});

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  @override
  String toString() => toJson().toString();
}

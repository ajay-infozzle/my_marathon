import 'package:json_annotation/json_annotation.dart';
import 'package:marathon/domain/entities/ledge/payment/rera.dart';
part 'payment_data.g.dart';

@JsonSerializable()
class PaymentData {
  @JsonKey(name: 'apartment_id')

  int? apartmentId;
  @JsonKey(name: 'milestone_id')
  String? milestoneId;
  @JsonKey(name: 'due_amount')
  String? dueAmount;
  Rera? rera;

  PaymentData({this.rera, this.dueAmount, this.apartmentId, this.milestoneId});

  Map<String, dynamic> toJson() => _$PaymentDataToJson(this);

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

  @override
  String toString() => toJson().toString();
}

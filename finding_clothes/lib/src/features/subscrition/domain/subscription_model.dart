import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  bool? isFreeTrial;
  String? namePlan;
  DateTime? startDate;
  DateTime? endDate;
  SubscriptionModel({
    required this.isFreeTrial,
    required this.namePlan,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}

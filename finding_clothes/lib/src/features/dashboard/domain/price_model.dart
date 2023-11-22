import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable()
class PriceModel {
  String value;
  double extracted_value;
  String currency;
  PriceModel({
    required this.value,
    required this.extracted_value,
    required this.currency,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      value: json['value'] as String,
      extracted_value: (json['extracted_value'] as num?)?.toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'extracted_value': instance.extracted_value,
      'currency': instance.currency,
    };

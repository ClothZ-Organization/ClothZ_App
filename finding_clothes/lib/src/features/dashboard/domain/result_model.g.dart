// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
      title: json['title'] as String,
      link: json['link'] as String,
      source: json['source'] as String,
      sourceIcon: json['sourceIcon'] as String?,
      price: json['price'] == null
          ? null
          : PriceModel.fromJson(json['price'] as Map<String, dynamic>),
      thumbnail: json['thumbnail'] as String,
      isBookMark: json['isBookMark'] as bool?,
    );

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'source': instance.source,
      'sourceIcon': instance.sourceIcon,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'isBookMark': instance.isBookMark,
    };

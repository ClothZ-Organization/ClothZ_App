// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResultModel _$ListResultModelFromJson(Map<String, dynamic> json) =>
    ListResultModel(
      visual_matches: (json['visual_matches'] as List<dynamic>)
          .map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListResultModelToJson(ListResultModel instance) =>
    <String, dynamic>{
      'visual_matches': instance.visual_matches,
    };

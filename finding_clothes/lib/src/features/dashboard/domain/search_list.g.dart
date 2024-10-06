// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchListModel _$SearchListModelFromJson(Map<String, dynamic> json) =>
    SearchListModel(
      imageUrl: json['imageUrl'] as String,
      visual_matches: (json['visual_matches'] as List<dynamic>?)
          ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchListModelToJson(SearchListModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'visual_matches': instance.visual_matches,
    };

import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_list.g.dart';

@JsonSerializable()
class SearchListModel {
  String imageUrl;
  List<ResultModel>? visual_matches;
  SearchListModel({required this.imageUrl, required this.visual_matches});

  factory SearchListModel.fromJson(Map<String, dynamic> json) =>
      _$SearchListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchListModelToJson(this);
}

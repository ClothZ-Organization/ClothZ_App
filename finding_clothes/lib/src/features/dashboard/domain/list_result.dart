
import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_result.g.dart';

@JsonSerializable()
class ListResultModel {
  List<ResultModel> visual_matches;
  ListResultModel({required this.visual_matches});

  factory ListResultModel.fromJson(Map<String, dynamic> json) =>
      _$ListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListResultModelToJson(this);
}


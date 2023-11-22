import 'package:finding_clothes/src/features/dashboard/domain/price_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_model.g.dart';

@JsonSerializable()
class ResultModel {
  String title;
  String link;
  String source;
  PriceModel? price;
  String thumbnail;

  ResultModel({
    required this.title,
    required this.link,
    required this.source,
    required this.price,
    required this.thumbnail,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}

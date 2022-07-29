import 'package:json_annotation/json_annotation.dart';
import 'package:news_app_test/features/data/models/results_model.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  String? status;
  String? copyright;
  String? section;
  @JsonKey(name: 'last_updated')
  String? lastUpdated;
  @JsonKey(name: 'num_results')
  int? numResults;
  List<Results>? results;

  News(
      {this.status,
      this.copyright,
      this.section,
      this.lastUpdated,
      this.numResults,
      this.results});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

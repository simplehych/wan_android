import 'package:wan_andoird/model/ArticleListData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ArticleListResult.g.dart';

@JsonSerializable()
class ArticleListResult{
  ArticleListData data;
  int errorCode;
  String errorMsg;
  factory ArticleListResult.fromJson(Map<String, dynamic> json) =>
      _$ArticleListResultFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleListResultToJson(this);

  ArticleListResult();

  @override
  String toString() {
    return 'ArticleListResult{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
  }
}
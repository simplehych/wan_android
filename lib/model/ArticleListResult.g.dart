// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleListResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListResult _$ArticleListResultFromJson(Map<String, dynamic> json) {
  return ArticleListResult()
    ..data = json['data'] == null
        ? null
        : ArticleListData.fromJson(json['data'] as Map<String, dynamic>)
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$ArticleListResultToJson(ArticleListResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

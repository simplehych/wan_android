// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleListData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListData _$ArticleListDataFromJson(Map<String, dynamic> json) {
  return ArticleListData(
      json['curPage'] as int,
      json['offset'] as int,
      json['pageCount'] as int,
      json['over'] as bool,
      json['size'] as int,
      json['total'] as int,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : NewsData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ArticleListDataToJson(ArticleListData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'offset': instance.offset,
      'pageCount': instance.pageCount,
      'over': instance.over,
      'size': instance.size,
      'total': instance.total,
      'datas': instance.datas
    };

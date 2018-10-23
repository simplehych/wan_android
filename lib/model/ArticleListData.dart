import 'package:json_annotation/json_annotation.dart';
import 'package:wan_andoird/model/NewsData.dart';
part 'ArticleListData.g.dart';

@JsonSerializable()

class ArticleListData{

  int curPage;
  int offset;
  int pageCount;
  bool over;
  int size;
  int total;
  List<NewsData> datas;

  factory ArticleListData.fromJson(Map<String, dynamic> json) => _$ArticleListDataFromJson(json);


  Map<String, dynamic> toJson() => _$ArticleListDataToJson(this);

  ArticleListData(this.curPage, this.offset, this.pageCount, this.over,
      this.size, this.total, this.datas);

  @override
  String toString() {
    return 'ArticleListData{curPage: $curPage, offset: $offset, pageCount: $pageCount, over: $over, size: $size, total: $total, datas: $datas}';
  }


}
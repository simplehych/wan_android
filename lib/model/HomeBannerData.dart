import 'package:json_annotation/json_annotation.dart';

part 'HomeBannerData.g.dart';
@JsonSerializable()
class HomeBannerData {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  HomeBannerData(this.desc, this.id, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url);

  factory HomeBannerData.fromJson(Map<String,dynamic> json) => _$HomeBannerDataFromJson(json);

  Map<String,dynamic> toJson() => _$HomeBannerDataToJson(this);
}

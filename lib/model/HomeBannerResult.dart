import 'package:wan_andoird/model/BaseResult.dart';
import 'package:wan_andoird/model/HomeBannerData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'HomeBannerResult.g.dart';

@JsonSerializable()
class HomeBannerResult extends BaseResult {
  List<HomeBannerData> data;

  HomeBannerResult(this.data, {int errorCode, String errorMsg})
      : super(errorCode, errorMsg);

  factory HomeBannerResult.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerResultFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerResultToJson(this);
}

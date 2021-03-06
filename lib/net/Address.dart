class Address {
  static const String WAN_ANDROID_HOST = "http://www.wanandroid.com/";

  static getHomeArticleList(int page) {
    return "${WAN_ANDROID_HOST}article/list/$page/json";
  }

  static getSearch(int page) {
    return "${WAN_ANDROID_HOST}article/query/$page/json";
  }

  static getHomeBanner() {
    return "${WAN_ANDROID_HOST}banner/json";
  }

  static getSearchHot() {
    return "${WAN_ANDROID_HOST}hotkey/json";
  }

  static getRecommendWeb() {
    return "${WAN_ANDROID_HOST}friend/json";
  }

  static getTree() {
    return "${WAN_ANDROID_HOST}tree/json";
  }

  static getArticleList(int page,String cid) {
    return "${WAN_ANDROID_HOST}article/list/$page/json?cid=$cid";
  }

  static const String host = "https://api.github.com/";

  ///我的用户信息 GET
  static getMyUserInfo() {
    return "${host}user";
  }

  ///用户信息 get
  static getUserInfo(userName) {
    return "${host}users/$userName";
  }

  static userStar(userName, sort) {
    sort ??= 'update';
    return "${host}users/$userName/starred?sort=$sort";
  }
}

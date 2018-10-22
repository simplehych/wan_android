class Address {
  static const String host = "https://api.github.com/";

  ///我的用户信息 GET
  static getMyUserInfo() {
    return "${host}user";
  }

  ///用户信息 get
  static getUserInfo(userName) {
    return "${host}users/$userName";
  }

  static userStar(userName,sort){
    sort ??= 'update';
    return "${host}users/$userName/starred?sort=$sort";
  }
}

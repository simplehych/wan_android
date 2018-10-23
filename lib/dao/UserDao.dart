import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:wan_andoird/LocalStorage.dart';
import 'package:wan_andoird/ab/provider/user/UserInfoDbProvider.dart';
import 'package:wan_andoird/config/Config.dart';
import 'package:wan_andoird/dao/DataResult.dart';
import 'package:wan_andoird/model/User.dart';
import 'package:wan_andoird/net/Address.dart';
import 'package:wan_andoird/net/HttpManager.dart';
import 'package:wan_andoird/net/ResultData.dart';

class UserDao {
  static initUserInfo(Store store) async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var result = await getUserInfoLocal();
  }

  /// 获取本地用户登录信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  /// 获取用户详细信息
  static getUserInfo(userName, {needDb = false}) async {
    UserInfoDbProvider provider = new UserInfoDbProvider();

    next() async {
      var result;
      if (userName == null) {
        result =
            await HttpManager.fetch(Address.getMyUserInfo(), null, null, null);
      } else {
        result = await HttpManager.fetch(
            Address.getUserInfo(userName), null, null, null);
      }
      if (result != null && result.result) {
        String starred = "---";
        if (result.data["type"] != "Organization") {
          DataResult countResult =
              await getUserStaredCountNet(result.data["login"]);
          if (countResult.result) {
            starred = countResult.data;
          }
        }
        User user = User.fromJson(result.data);
        user.starred = starred;
        if (userName == null) {
          LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
        } else {
          if (needDb) {
            provider.insert(userName, json.encode(user.toJson()));
          }
        }
        return new DataResult(user, true);
      } else {
        return new DataResult(result.data, false);
      }
    }

    if (needDb) {
      User user = await provider.getUserInfo(userName);
      if (user == null) {
        return await next();
      }
      DataResult dataResult = new DataResult(user, true, next: next());
      return dataResult;
    }
    return await next();
  }

  static getUserStaredCountNet(userName) async {
    String url = Address.userStar(userName, null) + "&per_page=1";
    ResultData result = await HttpManager.fetch(url, null, null, null);
    if (result != null && result.result && result.headers != null) {
      try {
        List<String> link = result.headers['link'];
        if (link != null) {
          int indexStart = link[0].lastIndexOf("page=") + 5;
          int indexEnd = link[0].lastIndexOf(">");
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = link[0].substring(indexStart, indexEnd);
            return new DataResult(count, true);
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return new DataResult(null, false);
  }
}

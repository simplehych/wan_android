import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:wan_andoird/dao/DataResult.dart';
import 'package:wan_andoird/dao/UserDao.dart';
import 'package:wan_andoird/model/User.dart';

class SqlManager {
  static const _VERSION = 1;
  static const _NAME = "wan_android_flutter.db";
  static Database _database;

  static init() async {
    String databasesPath = await getDatabasesPath();
    DataResult userResult = await UserDao.getUserInfoLocal();
    String dbName = _NAME;
    if (userResult != null && userResult.result) {
      User user = userResult.data;
      if (user != null && user.login != null) {
        dbName = '${user.login}_$_NAME';
      }
    }
    String path = '$databasesPath$dbName';
    if (Platform.isIOS) {
      path = '$databasesPath/$dbName';
    }
    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      //
    });
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var result = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return result != null && result.length > 0;
  }

  static getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static close() {
    _database?.close();
    _database = null;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/task.dart';
import 'dart:convert';

class DbHelper {
  static Database? _db;
  static final int? _version = 1;
  static final String? _tableName = "task";
  static Future<void> initdb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "task.db";
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title	STRING,note	TEXT, date STRING,"
            "startTime STRING,endTime STRING,"
            "remind INTEGER,repeat STRING,"
            "color INTEGER,"
            "isCompleted)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function called");
    return await _db?.insert(_tableName!, jsonDecode(task!.toJson())) ?? 1;
  }
}

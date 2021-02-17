import 'dart:async';
import 'package:activator/models/ServerModel.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  static Database _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return _db;
    }
    try {
      String _path = await getDatabasesPath() + 'example';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE server_items (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, url STRING, token STRING, complete BOOLEAN)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<int> insert(String table, ServerModel model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, ServerModel model) async =>
      await _db.update(table, model.toMap(),
          where: 'id = ?',
          whereArgs: [model.id, model.title, model.url, model.token]);

  static Future<int> delete(String table, ServerModel model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}
import 'package:activator/database/DB.dart';
import 'package:activator/models/ServerModel.dart';

class Repository {
  
  final DataBase db = DataBase();
  
  Future insertServer(String table, ServerModel model) => DataBase.insert(table, model);
  Future updateServer(String table, ServerModel model) => DataBase.update(table, model);
  Future deleteServer(String table, ServerModel model) => DataBase.delete(table, model);
}
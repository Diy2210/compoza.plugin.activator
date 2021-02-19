import 'package:flutter/material.dart';
import 'package:activator/views/ServersList.dart';
import 'package:activator/database/DB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBase.init();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServersList();
  }
}
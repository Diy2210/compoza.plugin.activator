import 'package:flutter/material.dart';
import 'package:activator/views/ServersList.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServersList();
  }
}
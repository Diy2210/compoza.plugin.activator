import 'dart:io';

import 'package:activator/models/CurrentUser.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:activator/screens/AuthScreen.dart';
import 'package:activator/screens/ServersScreen.dart';
import 'package:activator/screens/EditServerScreen.dart';
import 'package:activator/screens/PluginListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // Hive.openBox<CurrentUser>('user_db');
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _authStateChanged = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compoza.NET Activator',
      theme: ThemeData(
        accentColor: const Color(0xff008000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: StreamBuilder(
          stream: _authStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ServersScreen();
            }
            return AuthScreen();
          }),
      routes: {
        ServersScreen.routeName: (ctx) => ServersScreen(),
        EditServerScreen.routeName: (ctx) => EditServerScreen(),
        PluginListScreen.routeName: (ctx) => PluginListScreen(),
      },
    );
  }
}

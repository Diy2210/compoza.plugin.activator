import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive/hive.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:i18n_extension/io/import.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:activator/screens/AuthScreen.dart';
import 'package:activator/screens/ServersScreen.dart';
import 'package:activator/screens/EditServerScreen.dart';
import 'package:activator/screens/PluginListScreen.dart';

import 'models/CurrentUser.dart';

TranslationsByLocale translations;

Future<void> loadTranslations() async {
  translations = Translations.byLocale(I18n.locale.toString()) +
      await GettextImporter().fromAssetDirectory("assets/local");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<CurrentUser>(CurrentUserAdapter());
  await Hive.openBox<CurrentUser>('user_db');
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ru'),
      ],
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CurrentUserInfo.dart';
import 'package:activator/models/CurrentUser.dart';
import 'package:activator/screens/ServersScreen.dart';
import 'package:activator/screens/AuthScreen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // var _box = Hive.openBox('user');
  // var box = Hive.openBox('user');
  Future<String> _userData;

  @override
  void initState() {
    super.initState();
    _userData = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('user') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff008080),
            ),
            height: 220,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  // child: CurrentUserInfo(CurrentUser()),
                  child: FutureBuilder<String>(
                    future: _userData,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError || snapshot.data.isEmpty) {
                            return CurrentUserInfo(CurrentUser());
                          } else {
                            return CurrentUserInfo(
                                CurrentUser.fromString(snapshot.data));
                          }
                      }
                    },
                  ),

                  // child: FutureBuilder<String>(
                  //   future: _userData,
                  //   builder:
                  //       (BuildContext context, AsyncSnapshot<String> snapshot) {
                  //     switch (snapshot.connectionState) {
                  //       case ConnectionState.waiting:
                  //         return const CircularProgressIndicator();
                  //       default:
                  //         if (snapshot.hasError || snapshot.data.isEmpty) {
                  //           return CurrentUserInfo(CurrentUser());
                  //         } else {
                  //           return CurrentUserInfo(
                  //               CurrentUser.fromString(snapshot.data));
                  //         }
                  //     }
                  //   },
                  // ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: const Text('Servers'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ServersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Do you want logout?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(
                                context, AuthScreen.routeName);
                          },
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CurrentUserInfo.dart';
import 'package:activator/models/CurrentUser.dart';
import 'package:activator/screens/ServersScreen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
              color: Colors.blue,
              image: DecorationImage(
                image: const AssetImage('assets/images/drawer_background.png'),
                fit: BoxFit.fill,
              ),
            ),
            // color: const Color(0xff446179),
            height: 220,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
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
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt_outlined),
            title: const Text('Servers'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ServersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text(
              'Notifications',
              style: TextStyle(color: Colors.grey),
            ),
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
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

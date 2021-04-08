import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'CurrentUserInfo.dart';
import 'package:activator/localization.dart';
import 'package:activator/helper/UserDataHelper.dart';
import 'package:activator/screens/ServersScreen.dart';
import 'package:activator/screens/AuthScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff008000),
            ),
            height: 230,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  bottom: 0,
                  child: Container(
                    child: CurrentUserInfo(UserDataHelper().getUser()),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 40,
                  child: Container(
                    height: 20,
                    child: Text("ver 1.0.1", style: TextStyle(color: Colors.white54))
                    ),
                  ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Servers'.i18n),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ServersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('Logout'.i18n),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout".i18n),
                      content: Text("Do you want logout?".i18n),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel".i18n, style: TextStyle(color: Color(0xff008000))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Logout".i18n, style: TextStyle(color: Color(0xff008000))),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            UserDataHelper().exit();
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

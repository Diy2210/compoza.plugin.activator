import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:activator/helper/UserDataHelper.dart';

import 'CurrentUserInfo.dart';
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
            height: 220,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: CurrentUserInfo(UserDataHelper().getUser()),
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
            leading: Icon(Icons.exit_to_app_outlined),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Do you want logout?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel", style: TextStyle(color: Color(0xff008000))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Logout", style: TextStyle(color: Color(0xff008000))),
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
          Divider(),
          Container(
              padding: EdgeInsets.all(10),
              height: 100,
              child: Text("V1.0.0")
          )
        ],
      ),
    );
  }
}

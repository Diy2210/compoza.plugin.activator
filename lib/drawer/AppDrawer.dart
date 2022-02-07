import 'package:activator/helper/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'CurrentUserInfo.dart';
import 'package:activator/localization.dart';
import 'package:activator/helper/AppInfoHelper.dart';
import 'package:activator/helper/UserDataHelper.dart';
import 'package:activator/screens/ServersScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var versionApp;

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
                    child: FutureBuilder(
                      future: AppInfoHelper().getVersionNumber(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if(snapshot.hasData) {
                          versionApp = snapshot.data;
                        }
                        return Text(
                          snapshot.hasData ? versionApp : "Loading ...",
                          style: TextStyle(color: Colors.white54),
                        );
                      }
                    ),
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
                    content: Text("Do you want to logout?".i18n),
                    actions: <Widget>[
                      TextButton(
                        child: Text("No".i18n,
                            style: TextStyle(color: Color(0xff008000))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Yes".i18n,
                            style: TextStyle(color: Color(0xff008000))),
                        onPressed: () {
                          UserDataHelper().exit();
                          Navigator.of(context).pop();
                          FirebaseHelper().signOut();
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

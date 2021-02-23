import 'package:flutter/material.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/EditScreenArguments.dart';
import 'package:activator/screens/EditServerScreen.dart';
import 'package:activator/widgets/server/ServerMenu.dart';
import 'package:activator/widgets/server/ServerList.dart';
import 'package:activator/drawer/AppDrawer.dart';

class ServersScreen extends StatelessWidget {
  static const routeName = '/servers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servers'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff446179),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditServerScreen.routeName,
                arguments: EditScreenArguments(
                  server: Server(),
                  saveHandler: ServerMenu().addNewServer,
                ),
              );
            },
          )
        ],
      ),
      body: ServersList(),
      drawer: AppDrawer(),
    );
  }
}
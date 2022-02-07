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
        title: const Text('Compoza.NET Activator'),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff008000),
      ),
      body: ServersList(),
      drawer: AppDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,
              EditServerScreen.routeName,
              arguments: EditScreenArguments(
                server: Server(),
                saveHandler: ServerMenu().addNewServer,
              ),
            );
          },
          child: Icon(Icons.add_outlined),
          backgroundColor: Color(0xff008000),
        )
    );
  }
}
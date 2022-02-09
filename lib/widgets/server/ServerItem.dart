import 'package:flutter/material.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/screens/PluginListScreen.dart';

class ServerItem extends StatelessWidget {
  final Server server;

  ServerItem(this.server);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PluginListScreen.routeName, arguments: server);
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          trailing: new Icon(Icons.arrow_forward_ios),
          title: Text(
            server.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            server.url,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
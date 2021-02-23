import 'package:flutter/material.dart';
import 'package:activator/widgets/server/ServerMenu.dart';
import 'package:activator/models/Server.dart';

class ServerItem extends StatelessWidget {
  final Server server;

  ServerItem(this.server);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   ServerDetailScreen.routeName,
        //   arguments: server,
        // );
        print(server.title);
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(
            server.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
          subtitle: Text(
            server.url,
            style: TextStyle(fontSize: 12),
          ),
          trailing: ServerMenu().serverMenu(context, server),
        ),
      ),
    );
  }
}

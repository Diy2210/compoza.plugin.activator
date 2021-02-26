import 'package:flutter/material.dart';

import 'package:activator/helper/FirestoreHelper.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/EditScreenArguments.dart';
import 'package:activator/screens/EditServerScreen.dart';
import 'package:activator/screens/PluginListScreen.dart';

class ServerItem extends StatelessWidget {
  final Server server;

  ServerItem(this.server);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, PluginListScreen.routeName);
        print(server.title);
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, PluginListScreen.routeName);
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.edit),
                        title: new Text('Edit'),
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.pushNamed(
                                context,
                                EditServerScreen.routeName,
                                arguments: EditScreenArguments(
                                  server: server,
                                  saveHandler: _editServer,
                                ),
                              )
                            }),
                    new ListTile(
                      leading: new Icon(Icons.delete),
                      title: new Text('Delete'),
                      onTap: () => {
                        Navigator.of(context).pop(),
                        alertDeleteServer(context, server),
                      },
                    ),
                  ],
                ),
              );
            });
      },
      child: Card(
        elevation: 5,
        child: ListTile(
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

  alertDeleteServer(ctx, Server server) {
    final dialog = AlertDialog(
      title: const Text('Delete server'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: <Widget>[
            Text(
              server.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(' will be deleted.'),
          ]),
          Divider(
            height: 10,
          ),
          const Text('Are you sure?'),
        ],
      ),
      actions: [
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            _deleteServer(server);
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
    showDialog(
      context: ctx,
      builder: (ctx) => dialog,
    );
  }
}

void _editServer(Server server) {
  FirestoreHelper.editServer(server);
}

void _deleteServer(Server server) {
  FirestoreHelper.deleteServer(server);
}

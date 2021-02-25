import 'package:flutter/material.dart';

import 'package:activator/helper/FirestoreHelper.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/EditScreenArguments.dart';
import 'package:activator/screens/EditServerScreen.dart';


class ServerMenu {
  void _askToDeleteServer(BuildContext ctx, Server server) {
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

  // Possible to manage state during these operations
  void addNewServer(Server server) {
    FirestoreHelper.addServer(server);
  }

  void _editServer(Server server) {
    FirestoreHelper.editServer(server);
  }

  void _deleteServer(Server server) {
    FirestoreHelper.deleteServer(server);
  }

  DropdownButton serverMenu(BuildContext ctx, Server server) {
    return DropdownButton(
      underline: Container(),
      icon: Icon(
        Icons.more_vert,
      ),
      items: [
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(width: 8),
              const Text('Edit'),
            ],
          ),
          value: 'edit',
        ),
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              SizedBox(width: 8),
              const Text('Delete'),
            ],
          ),
          value: 'delete',
        ),
      ],
      onChanged: (itemIdentifier) {
        if (itemIdentifier == 'edit') {
          Navigator.pushNamed(
            ctx,
            EditServerScreen.routeName,
            arguments: EditScreenArguments(
              server: server,
              saveHandler: _editServer,
            ),
          );
        }
        if (itemIdentifier == 'delete') {
          _askToDeleteServer(ctx, server);
        }
      },
    );
  }
}

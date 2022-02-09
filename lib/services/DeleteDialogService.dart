import 'package:activator/localization.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/services/FirestoreService.dart';
import 'package:flutter/material.dart';

class DeleteDialogService {
  showDeleteDialog(BuildContext context, Server server) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Delete server'.i18n),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: <Widget>[
                  Text(
                    server.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(' will be deleted.'.i18n),
                ]),
                Divider(
                  height: 10,
                ),
                Text('Are you sure?'.i18n),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'.i18n),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('OK'.i18n),
                onPressed: () {
                  FirestoreService.deleteServer(server);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

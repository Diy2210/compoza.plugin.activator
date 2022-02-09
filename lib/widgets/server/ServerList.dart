import 'package:activator/screens/EditServerScreen.dart';
import 'package:activator/services/DeleteDialogService.dart';
import 'package:activator/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:activator/localization.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/widgets/server/ServerItem.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class ServersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getServers(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data?.docs.length == 0) {
          return Center(
            child: Text("Empty list".i18n),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (ctx, index) {
            final doc = snapshot.data?.docs[index];
            Server server = Server(
              title: doc!['title'],
              url: doc['url'],
              token: doc['token'],
              userID: doc['userID'],
              serverID: doc.id,
            );
            return SwipeActionCell(
              key: ObjectKey(doc),
              trailingActions: <SwipeAction>[
                SwipeAction(
                  color: Colors.orangeAccent,
                  title: 'edit'.i18n,
                  icon: Icon(Icons.edit, color: Colors.white),
                  onTap: (CompletionHandler handler) async {
                    await handler(false);
                    FirestoreService.editServer(server);
                    await Navigator.of(context).pushReplacementNamed(EditServerScreen.routeName,
                      arguments: server
                    );
                  },
                ),
                SwipeAction(
                  color: Colors.red,
                  title: 'delete'.i18n,
                  icon: Icon(Icons.delete, color: Colors.white),
                  onTap: (CompletionHandler handler) async {
                    await handler(false);
                    DeleteDialogService().showDeleteDialog(context, server);
                    // FirestoreService.deleteServer(server);
                  },
                ),
              ],
              child: ServerItem(server),
            );
          },
        );
      },
    );
  }
}

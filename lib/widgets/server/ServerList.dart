import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:activator/localization.dart';
import 'package:activator/helper/FirestoreHelper.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/widgets/server/ServerItem.dart';

class ServersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().getServers(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.docs.length <= 0) {
          return Center(
            child: Text("Empty list".i18n),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (ctx, index) {
            final doc = snapshot.data.docs[index];
            return ServerItem(
              Server(
                title: doc['title'],
                url: doc['url'],
                token: doc['token'],
                userID: doc['userID'],
                serverID: doc.id,
              ),
            );
          },
        );
      },
    );
  }
}

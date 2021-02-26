import 'package:flutter/material.dart';

import 'package:activator/api/ActivatorApi.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/Plugin.dart';
import 'package:activator/screens/ServersScreen.dart';

import 'PluginItem.dart';

class PluginList extends StatelessWidget {
  // final Server server;
  //
  // PluginList(this.server)

  @override
  Widget build(BuildContext context) {
    final api = ActivatorApi();

    return FutureBuilder<Map<String, dynamic>>(
      // future: api.getPluginList(server),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, ServersScreen.routeName);

          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Something is going wrong"),
          ));
        }
        // return ListView.builder(
        //   itemCount: snapshot.data.length,
        //   itemBuilder: (ctx, index) {
        //     final doc = snapshot.data[index];
        //     return PluginItem(
        //       Plugin(
        //         title: doc['title'],
        //         plugin: doc['plugin'],
        //         status: doc.status,
        //         id: doc.id,
        //       ),
        //     );
        //   },
        // );

        return ListView(
            children: [
              // PluginItem(
              //   Plugin(
              //     title: 'TEST',
              //     plugin: 'TEST',
              //     status: true,
              //     id: '1'
              //   )
              // )
              Text("TEST")
            ]
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:activator/api/ActivatorApi.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/Plugin.dart';
import 'package:activator/screens/ServersScreen.dart';

import 'PluginItem.dart';

class PluginList extends StatelessWidget {
  final Server server;

  PluginList(this.server);

//   @override
//   _PluginListState createState() => _PluginListState();
// }
//
// class _PluginListState extends State<PluginList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plugin>>(
        future: ActivatorApi.getPluginList(server),
        builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.data == null) {
        return Center(
          child: const Text('Something is going wrong'),
        );
      }

      return  ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (ctx, index) {
        return PluginItem(snapshot.data[index]);
      },
      );
      });
  }
}

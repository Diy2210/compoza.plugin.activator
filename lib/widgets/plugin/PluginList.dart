import 'package:flutter/material.dart';
import 'package:activator/localization.dart';
import 'package:activator/api/ActivatorApi.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/Plugin.dart';
import 'PluginItem.dart';

class PluginList extends StatelessWidget {
  final Server server;

  PluginList(this.server);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plugin>?>(
        future: ActivatorApi.getPluginList(server),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!snapshot.hasData) {
            return Center(
              child: Text('Empty list'.i18n),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text('Something is going wrong'.i18n),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (ctx, index) {
              return PluginItem(snapshot.data![index], server);
            },
          );
        });
  }
}

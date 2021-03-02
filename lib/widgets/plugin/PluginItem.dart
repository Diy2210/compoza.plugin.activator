import 'package:flutter/material.dart';

import 'package:activator/models/Plugin.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/api/ActivatorApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PluginItem extends StatelessWidget {
  final Plugin plugin;
  final Server server;

  PluginItem(this.plugin, this.server);

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile.adaptive(
      title: Text(
        plugin.title,
      ),
      value: plugin.status,
      onChanged: (bool value) {
        // plugin.status = value;
        plugin.status = value;
        ActivatorApi.updatePluginStatus(server, plugin, value);

        // SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;
        // prefs.setBool('switch', true);
      },
    );
  }
}

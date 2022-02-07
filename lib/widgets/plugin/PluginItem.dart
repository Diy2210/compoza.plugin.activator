import 'package:flutter/material.dart';

import 'package:activator/models/Plugin.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/api/ActivatorApi.dart';

class PluginItem extends StatefulWidget {
  final Plugin plugin;
  final Server server;

  PluginItem(this.plugin, this.server);

  @override
  _PluginItemState createState() => _PluginItemState();
}

class _PluginItemState extends State<PluginItem> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(
        widget.plugin.title,
      ),
      value: widget.plugin.status,
      onChanged: (bool value) {
        ActivatorApi.updatePluginStatus(widget.server, widget.plugin, value);
        setState(() {
          widget.plugin.status = value;
        });
      },
    );
  }
}

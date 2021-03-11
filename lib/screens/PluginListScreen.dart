import 'package:flutter/material.dart';

import 'package:activator/models/Server.dart';
import 'package:activator/widgets/plugin/PluginList.dart';

class PluginListScreen extends StatelessWidget {
  static const routeName = '/plugin_list';

  @override
  Widget build(BuildContext context) {
    final Server server = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(server.title),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff008000),
      ),
      // body: PluginList()
      body: PluginList(server)
    );
  }
}
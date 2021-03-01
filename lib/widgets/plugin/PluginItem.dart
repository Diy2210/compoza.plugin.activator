import 'package:flutter/material.dart';

import 'package:activator/models/Plugin.dart';

class PluginItem extends StatelessWidget {
  final Plugin plugin;

  PluginItem(this.plugin);

  // bool _plugin = false;

  @override
  Widget build(BuildContext context) {
    return  SwitchListTile.adaptive(
      title: Text(
        plugin.title,
        //   style: TextStyle(
        //     color: Colors.blue,
        //     fontWeight: FontWeight.w800,
        //     fontSize: 20
        // ),
      ),
      value: plugin.status,
      // activeColor: Colors.red,
      // inactiveTrackColor: Colors.grey,
      onChanged: (bool value) {
        plugin.status = value;
      },
    );

    // return Scaffold(
    //     body: Center(
    //         child: SwitchListTile(
    //             title: const Text('TEST'),
    //             value: _plugin,
    //             onChanged: (bool value) {
    //               _plugin = value;
    //             }
    //             )
    //     )
    // );
  }
}

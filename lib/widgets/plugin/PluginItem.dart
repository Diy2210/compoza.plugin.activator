import 'package:flutter/material.dart';

import 'package:activator/models/Plugin.dart';

class PluginItem extends StatelessWidget {
  final Plugin plugin;

  PluginItem(this.plugin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Card(
                elevation: 5,
                child: SwitchListTile(title: Text(plugin.title,
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
                    // plugin.status = value;
                    print("Switch pressed");
                  },
                )
            )
        )
    );
  }
}
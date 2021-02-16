import 'package:activator/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:activator/items/ServerItem.dart';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/DB.dart';
import 'package:activator/views/PluginsList.dart';
import 'package:http/http.dart';

class ServersList extends StatefulWidget {
  @override
  _ServersListState createState() => _ServersListState();
}

class _ServersListState extends State<ServersList> {
  final DataBase db = DataBase();
  final DBHelper helper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ToDo List"),
        ),
        body: StreamBuilder(
            stream: helper.servers,
            // ignore: missing_return
            builder: (BuildContext context,
                AsyncSnapshot<List<ServerModel>> snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ServerModel model = snapshot.data[index];
                    });
              }
            }));
  }
}

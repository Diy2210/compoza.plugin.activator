import 'package:activator/helper/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:activator/items/ServerItem.dart';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/DB.dart';
import 'package:activator/views/PluginsList.dart';
import 'package:activator/views/EditServer.dart';

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
          title: Text("Compoza.net"),
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
                      return Dismissible(
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          // helper.deleteServer(model.id);
                          print(model.id);
                        },
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 35, 0, 8),
                            child: //Icon(Icons.delete)
                                Text(
                              "DELETE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        child: Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(model.title),
                            // leading: Checkbox(
                            //   value: model.isDone,
                            //   activeColor: Colors.red,
                            //   onChanged: (bool value) {
                            //     bloc.updateTodo(model.id);
                            //   },
                            // ),
                            subtitle: Text(model.url),
                            isThreeLine: true,
                          ),
                        ),
                        key: UniqueKey(),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "Empty list",
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditServer(
                    helper: helper,
                  )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:activator/items/ServerItem.dart';
import 'package:flutter/material.dart';
import 'package:activator/helper/DBHelper.dart';
import 'package:activator/items/ServerItem.dart';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/DB.dart';

class EditServer extends StatefulWidget {
  // final DataBase db;

  final DBHelper helper;

  EditServer({this.helper});
  // EditServer({this.db, this.helper});

  @override
  _EditServerState createState() => _EditServerState();
}

class _EditServerState extends State<EditServer> {

  final title = TextEditingController();
  final url = TextEditingController();
  final token = TextEditingController();

  String _title, _url, _token;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add new server"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.pop(context);
                ServerItem item = ServerItem(title: _title, url: _url, token: _token, complete: false);
                print(item.title + "" + item.url + "" + item.token);
                widget.helper.saveServer(ServerItem.table, item);
                // DataBase.insert(ServerItem.table, item);
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: title,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
                suffixIcon: IconButton(
                  onPressed: () => title.clear(),
                  icon: Icon(Icons.clear),
                )
              ),
              onChanged: (value) {
                _title = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
          new ListTile(
            // leading: Icon(Icons.view_headline),
            title: new TextField(
              controller: url,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Url',
                  suffixIcon: IconButton(
                    onPressed: () => url.clear(),
                    icon: Icon(Icons.clear),
                  )
              ),
              onChanged: (value) {
                _url = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
          new ListTile(
            title: new TextField(
              controller: token,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Token',
                  suffixIcon: IconButton(
                    onPressed: () => token.clear(),
                    icon: Icon(Icons.clear),
                  )
              ),
              onChanged: (value) {
                _token = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}

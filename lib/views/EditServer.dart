import 'package:activator/items/ServerItem.dart';
import 'package:flutter/material.dart';
import 'package:activator/helper/DBHelper.dart';
import 'package:activator/items/ServerItem.dart';
import 'package:activator/models/ServerModel.dart';
import 'package:activator/database/DB.dart';

class EditServer extends StatefulWidget {
  final DBHelper helper;

  EditServer({this.helper});

  @override
  _EditServerState createState() => _EditServerState();
}

class _EditServerState extends State<EditServer> {

  String title, url, token;

  final _title = TextEditingController();
  final _url = TextEditingController();
  final _token = TextEditingController();

  // checkTextFieldEmptyOrNot() {
  //   title = _title.text;
  //   url = _url.text;
  //   token = _token.text;
  //   if(title == '' || url == '' || token == '') {
  //     print("All fields are required");
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _title.addListener(() {
      setState(() { });
    });

    _url.addListener(() {
      setState(() { });
    });

    _token.addListener(() {
      setState(() { });
    });
  }

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
                  ServerItem item = ServerItem(title: title, url: url, token: token);
                  // DataBase.insert(ServerItem.table, item);
                  widget.helper.saveServer(ServerItem.table, item);
                  setState(() => title = '');
                  setState(() => url = '');
                  setState(() => token = '');
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _title,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
                suffixIcon: _title.text.isNotEmpty
                  ? IconButton(
                  onPressed: () => _title.clear(),
                  icon: Icon(Icons.clear),
                ): null,
              ),
              onChanged: (value) {
                title = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
          new ListTile(
            title: new TextField(
              controller: _url,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Url',
                  suffixIcon: _url.text.isNotEmpty
                      ? IconButton(
                    onPressed: () => _url.clear(),
                    icon: Icon(Icons.clear),
                  ): null,
              ),
              onChanged: (value) {
                url = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
          new ListTile(
            title: new TextField(
              controller: _token,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Token',
                  suffixIcon: _token.text.isNotEmpty
                      ? IconButton(
                    onPressed: () => _token.clear(),
                    icon: Icon(Icons.clear),
                  ): null,
              ),
              onChanged: (value) {
                token = value;
              },
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}

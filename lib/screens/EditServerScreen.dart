import 'package:activator/screens/ServersScreen.dart';
import 'package:flutter/material.dart';
import 'package:activator/localization.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/widgets/server/EditServerForm.dart';

class EditServerScreen extends StatefulWidget {
  static const routeName = '/edit-server';

  @override
  _EditServerScreenState createState() => _EditServerScreenState();
}

class _EditServerScreenState extends State<EditServerScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Server server = ModalRoute.of(context)?.settings.arguments as Server;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: server.serverID == ''
            ? Text('Add New Server'.i18n)
            : Text('Edit Server'.i18n),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff008000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed(ServersScreen.routeName),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: EditServerForm(server, server.serverID == '' ? 'new_server' : 'edit_server'),
            ),
    );
  }
}

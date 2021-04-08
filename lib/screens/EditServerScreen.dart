import 'package:flutter/material.dart';

import 'package:activator/localization.dart';
import 'package:activator/models/Server.dart';
import 'package:activator/models/EditScreenArguments.dart';
import 'package:activator/widgets/server/EditServerForm.dart';

class EditServerScreen extends StatefulWidget {
  static const routeName = '/edit-server';

  @override
  _EditServerScreenState createState() => _EditServerScreenState();
}

class _EditServerScreenState extends State<EditServerScreen> {
  EditScreenArguments args;
  Server _server;

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _saveForm() async {
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    args.saveHandler(_server);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _server = args.server;
    return Scaffold(
      appBar: AppBar(
        title: _server.serverID.isEmpty
            ? Text('Add New Server'.i18n)
            : Text('Edit Server'.i18n),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff008000),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.all(10),
        child: EditServerForm(
          _formKey,
          _server,
        ),
      ),
    );
  }
}

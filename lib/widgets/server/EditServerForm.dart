import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validators;

import 'package:activator/models/Server.dart';

class EditServerForm extends StatefulWidget {
  final Key _formKey;
  final Server _server;

  EditServerForm(this._formKey, this._server);

  @override
  _EditServerFormState createState() => _EditServerFormState();
}

class _EditServerFormState extends State<EditServerForm> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {});
    });
    _urlController.addListener(() {
      setState(() {});
    });
    _tokenController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Form(
        key: widget._formKey,
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget._server.title,
              autocorrect: true,
              enableSuggestions: true,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              // controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                // suffixIcon: _titleController.text.length > 0
                //     ? IconButton(
                //         onPressed: () => _titleController.clear(),
                //         icon: Icon(Icons.clear, color: Colors.grey),
                //       )
                //     : null,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter server name';
                }
                return null;
              },
              onSaved: (value) {
                widget._server.title = value.trim();
              },
            ),
            TextFormField(
              initialValue: widget._server.url,
              //controller: _urlController,
              decoration: InputDecoration(
                labelText: 'URL',
                // suffixIcon: _urlController.text.length > 0
                //     ? IconButton(
                //         onPressed: () => _urlController.clear(),
                //         icon: Icon(Icons.clear, color: Colors.grey),
                //       )
                //     : null,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value.isEmpty || !validators.isURL(value)) {
                  return 'Please enter valid server URL';
                }
                return null;
              },
              onSaved: (value) {
                widget._server.url = value.trim();
              },
            ),
            TextFormField(
              initialValue: widget._server.token,
              //controller: _tokenController,
              decoration: InputDecoration(
                labelText: 'Token',
                // suffixIcon: _tokenController.text.length > 0
                //     ? IconButton(
                //         onPressed: () => _tokenController.clear(),
                //         icon: Icon(Icons.clear, color: Colors.grey),
                //       )
                //     : null,
              ),
              maxLines: 5,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the token';
                }
                return null;
              },
              onSaved: (value) {
                widget._server.token = value.trim();
              },
            ),
          ],
        ),
      ),
    );
  }
}

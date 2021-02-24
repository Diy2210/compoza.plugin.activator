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
  TextEditingController _titleController;
  TextEditingController _urlController;
  TextEditingController _tokenController;

  FocusNode titleFocus = new FocusNode();
  FocusNode urlFocus = new FocusNode();
  FocusNode tokenFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget._server.title);
    _urlController = TextEditingController(text: widget._server.url);
    _tokenController = TextEditingController(text: widget._server.token);

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
              focusNode: titleFocus,
              autocorrect: true,
              enableSuggestions: true,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff008080), width: 2.0),
                ),
                labelText: 'Server Title',
                labelStyle: TextStyle(
                    color: titleFocus.hasFocus ? Color(0xff008080) : Colors.grey
                ),
                suffixIcon: _titleController.text.length > 0
                    ? IconButton(
                        onPressed: () => _titleController.clear(),
                        icon: Icon(Icons.clear, color: Colors.grey),
                      )
                    : null,
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
            Divider(),
            TextFormField(
              focusNode: urlFocus,
              controller: _urlController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff008080), width: 2.0),
                ),
                labelText: 'Server URL',
                labelStyle: TextStyle(
                    color: urlFocus.hasFocus ? Color(0xff008080) : Colors.grey
                ),

                suffixIcon: _urlController.text.length > 0
                    ? IconButton(
                        onPressed: () => _urlController.clear(),
                        icon: Icon(Icons.clear, color: Colors.grey),
                      )
                    : null,
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
            Divider(),
            TextFormField(
              focusNode: tokenFocus,
              controller: _tokenController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff008080), width: 2.0),
                ),
                labelText: 'Authorization Token',
                labelStyle: TextStyle(
                    color: tokenFocus.hasFocus ? Color(0xff008080) : Colors.grey
                ),
                suffixIcon: _tokenController.text.length > 0
                    ? IconButton(
                        onPressed: () => _tokenController.clear(),
                        icon: Icon(Icons.clear, color: Colors.grey),
                      )
                    : null,
              ),
              maxLines: 3,
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

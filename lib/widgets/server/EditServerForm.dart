import 'package:activator/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validators;
import 'package:activator/localization.dart';
import 'package:activator/models/Server.dart';

class EditServerForm extends StatefulWidget {
  final Server server;
  final String editType;

  EditServerForm(this.server, this.editType);

  @override
  _EditServerFormState createState() => _EditServerFormState();
}

class _EditServerFormState extends State<EditServerForm> {
  bool saveButton = false;
  TextEditingController? _titleController;
  TextEditingController? _urlController;
  TextEditingController? _tokenController;

  FocusNode titleFocus = new FocusNode();
  FocusNode urlFocus = new FocusNode();
  FocusNode tokenFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.server.title);
    _urlController = TextEditingController(text: widget.server.url);
    _tokenController = TextEditingController(text: widget.server.token);

    _titleController?.addListener(() {
      setState(() {});
    });

    _urlController?.addListener(() {
      setState(() {});
    });

    _tokenController?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController?.dispose();
    _urlController?.dispose();
    _tokenController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Form(
        child: Column(children: [
          Expanded(
            flex: 5,
            child: Container(
              child: ListView(
                children: [

                  ///Title field
                  TextFormField(
                    focusNode: titleFocus,
                    autocorrect: true,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xff008000), width: 2.0),
                      ),
                      labelText: 'Server Title'.i18n,
                      labelStyle: TextStyle(
                          color: titleFocus.hasFocus
                              ? Color(0xff008000)
                              : Colors.grey),
                      suffixIcon: _titleController?.text.length != 0
                          ? IconButton(
                              onPressed: () => _titleController?.clear(),
                              icon: Icon(Icons.clear, color: Color(0xff008000)),
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter server name'.i18n;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        saveButton = true;
                        widget.server.title = value.trim();
                      });
                    },
                  ),

                  Divider(),

                  ///URL field
                  TextFormField(
                    focusNode: urlFocus,
                    controller: _urlController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xff008000), width: 2.0),
                      ),
                      labelText: 'Server URL'.i18n,
                      labelStyle: TextStyle(
                          color: urlFocus.hasFocus
                              ? Color(0xff008000)
                              : Colors.grey),
                      suffixIcon: _urlController?.text.length != 0
                          ? IconButton(
                              onPressed: () => _urlController?.clear(),
                              icon: Icon(Icons.clear, color: Color(0xff008000)),
                            )
                          : null,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || !validators.isURL(value)) {
                          return 'Please enter valid server URL'.i18n;
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        saveButton = true;
                        widget.server.url = value.trim();
                      });
                    },
                  ),

                  Divider(),

                  ///Token field
                  TextFormField(
                    focusNode: tokenFocus,
                    controller: _tokenController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xff008000), width: 2.0),
                      ),
                      labelText: 'Authorization Token'.i18n,
                      labelStyle: TextStyle(
                          color: tokenFocus.hasFocus
                              ? Color(0xff008000)
                              : Colors.grey),
                      suffixIcon: _tokenController?.text.length != 0
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Color(0xff008000)),
                              onPressed: () {
                                _tokenController?.clear();
                                setState(() {
                                  saveButton = false;
                                });
                              })
                          : null,
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter the token'.i18n;
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        saveButton = true;
                        widget.server.token = value.trim();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          ///Save button
          Visibility(
            visible: saveButton,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff008000)),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                  child: Text(
                    'Save server',
                    style: TextStyle(fontSize: 17.0, color: Color(0xff008000)),
                  ),
                  onPressed: () {
                    widget.editType == 'new_server'
                    ? FirestoreService.addServer(widget.server)
                    : FirestoreService.editServer(widget.server);
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:platform/platform.dart';
import 'package:activator/models/SignInMethod.dart';
import 'AuthEmailForm.dart';
import 'SignUpEmailForm.dart';

class AuthList extends StatefulWidget {
  final void Function(
      BuildContext context,
      String method, [
      String email,
      String password,
      ]) submitFn;

  AuthList(this.submitFn,);

  @override
  _AuthListState createState() => _AuthListState();
}

class _AuthListState extends State<AuthList> {
  @override
  Widget build(BuildContext context) {
    final borderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    );
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Text("Compoza.NET Activator",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal))),
                  AuthEmailForm(widget.submitFn),
                  SignInButton(
                    Buttons.Google,
                    shape: borderShape,
                    onPressed: () =>
                        widget.submitFn(context, SignInMethod.google),
                  ),
                  SignInButton(
                    Buttons.FacebookNew,
                    shape: borderShape,
                    onPressed: () =>
                        widget.submitFn(context, SignInMethod.facebook),
                  ),
                  if (LocalPlatform().isIOS)
                    SignInButton(
                      Buttons.AppleDark,
                      shape: borderShape,
                      onPressed: () =>
                          widget.submitFn(context, SignInMethod.apple),
                    ),
                  SignUpEmailForm(widget.submitFn)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

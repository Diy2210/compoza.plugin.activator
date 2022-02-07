import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:activator/models/SignInMethod.dart';
import 'package:activator/helper/AppInfoHelper.dart';
import 'package:activator/localization.dart';

class AuthList extends StatefulWidget {
  final void Function(
    BuildContext context,
    String method, [
    String email,
    String password,
  ]) submitFn;

  AuthList(this.submitFn);

  @override
  _AuthListState createState() => _AuthListState();
}

class _AuthListState extends State<AuthList> {
  var versionApp;

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
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/compoza_logo.png',
                      width: 300,
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    shape: borderShape,
                    onPressed: () =>
                        widget.submitFn(context, SignInMethod.google),
                  ),
                  SignInButton(
                    Buttons.Facebook,
                    shape: borderShape,
                    onPressed: () =>
                        widget.submitFn(context, SignInMethod.facebook),
                  ),
                  // if (Platform.isAndroid)
                  SignInButton(
                    Buttons.Twitter,
                    shape: borderShape,
                    onPressed: () =>
                        widget.submitFn(context, SignInMethod.twitter),
                  ),
                  if (Platform.isIOS)
                    SignInButton(
                      Buttons.AppleDark,
                      shape: borderShape,
                      onPressed: () =>
                          widget.submitFn(context, SignInMethod.apple),
                    ),
                ],
              ),
            ),
            FutureBuilder(
              future: AppInfoHelper().getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if(snapshot.hasData) {
                  versionApp = snapshot.data;
                }
                return Text(
                  snapshot.hasData ? versionApp : 'Loading...'.i18n,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

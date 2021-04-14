import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:activator/localization.dart';
import 'package:activator/widgets/auth/AuthList.dart';
import 'package:activator/models/SignInMethod.dart';
import 'package:activator/helper/UserDataHelper.dart';
import 'package:activator/helper/FirebaseHelper.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;

  Future<void> _tryToSignIn(BuildContext context,
      String method, [
        String email = '',
        String password = '',
        String username = '',
        bool isLogin,
      ]) async {
    String message;
    UserCredential userCredential;
    final authService = FirebaseHelper();
    try {
      setState(() {
        _isLoading = true;
      });
      if (method == SignInMethod.google) {
        userCredential = await authService.signInWithGoogle();
      } else if (method == SignInMethod.facebook) {
        userCredential = await authService.signInWithFacebook();
      } else if(method == SignInMethod.apple) {
        userCredential = await authService.signInWithApple();
      // } else if(method == SignInMethod.twitter) {
      //   userCredential = await authService.signInWithTwitter();
      } else {
        message = 'Sign in method %s is not implemented'.i18n;
      }
    } catch (error) {
      if (error.code == 'account-exists-with-different-credential') {
        // try to link with other account
        userCredential = await authService.tryToLink(
          context,
          error.email,
          // we need it in case email/password provider is used
          password,
          error.credential,
        );
      } else if (error.message != null) {
        message = error.message;
      }
    } finally {
      if (userCredential != null) {
        authService.signInMethod = method;
        await UserDataHelper().cacheUserData(method, authService.currentUser);
      }

      if (message != null) {
        ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AuthList(_tryToSignIn),
            _isLoading
                ? Container(
              color: Colors.black45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff008000)),
                    ),
                  ),
                ],
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}

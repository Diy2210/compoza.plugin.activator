import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:activator/helper/FirestoreHelper.dart';
import 'package:activator/models/CurrentUser.dart';
import 'package:activator/widgets/auth/AuthForm.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
      BuildContext ctx,
      String email,
      String password,
      String username,
      bool isLogin,
      ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final userDetails =
        await FirestoreHelper().getUserData(authResult.user.uid);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'user',
          CurrentUser(
            name: userDetails.data()['username'] ?? 'Anonimous',
            email: authResult.user.email,
            avatar: authResult.user.photoURL,
          ).toString(),
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirestoreHelper()
            .setUserData(authResult.user.uid, username, email);
      }
    } on FirebaseAuthException catch (error) {
      final message = error.message ?? 'Pelase check your credentials';

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}

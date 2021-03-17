import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    BuildContext ctx,
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isPasswordVisible = false;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        context,
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
      );
    }
  }

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  FocusNode emailFocus = new FocusNode();
  FocusNode usernameFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _usernameController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(
                  left: 90,
                  right: 90,
                  bottom: 10,
                ),
                width: double.infinity,
                child: Text("Compoza.NET Activator",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal))),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 10,
              color: Colors.grey[50],
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        focusNode: emailFocus,
                        cursorColor: Color(0xff008000),
                        key: const ValueKey('email'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff008000), width: 2.0),
                          ),
                          labelText: 'Email address',
                          labelStyle: TextStyle(
                              color: emailFocus.hasFocus ? Color(0xff008000) : Colors.grey
                          ),
                          suffixIcon: _emailController.text.length > 0
                              ? IconButton(
                                  onPressed: () => _emailController.clear(),
                                  icon: Icon(Icons.clear, color: Colors.grey),
                                )
                              : null,
                        ),
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      Divider(),
                      if (!_isLogin)
                        TextFormField(
                          focusNode: usernameFocus,
                          cursorColor: Color(0xff008000),
                          key: const ValueKey('username'),
                          autocorrect: true,
                          textCapitalization: TextCapitalization.words,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xff008000), width: 2.0),
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: usernameFocus.hasFocus ? Color(0xff008000) : Colors.grey
                            ),
                            suffixIcon: _usernameController.text.length > 0
                                ? IconButton(
                                    onPressed: () =>
                                        _usernameController.clear(),
                                    icon: Icon(Icons.clear, color: Colors.grey),
                                  )
                                : null,
                          ),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      Divider(),
                      TextFormField(
                        focusNode: passwordFocus,
                        cursorColor: Color(0xff008000),
                        key: const ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff008000), width: 2.0),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: passwordFocus.hasFocus ? Color(0xff008000) : Colors.grey
                          ),
                          suffixIcon: _passwordController.text.length > 0
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.grey),
                                )
                              : null,
                        ),
                        obscureText: !_isPasswordVisible,
                        onSaved: (value) {
                          _userPassword = value;
                        },
                      ),
                      SizedBox(height: 12),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Color(0xff008000),
                          child: Text(
                            _isLogin ? 'Login' : 'Signup',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                      if (!widget.isLoading)
                        TextButton(
                          child: Text(
                              _isLogin
                                  ? 'Create new account'
                                  : 'I already have an account',
                              style: TextStyle(color: Color(0xff008000))),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Container(
                              child: IconButton(
                                icon: Image.asset('assets/images/google.png'),
                                iconSize: 55.0,
                                onPressed: () {
                                  setState(() {
                                    signInWithGoogle();
                                    _isLogin = !_isLogin;
                                  });
                                },
                              )),
                          Container(
                              child: IconButton(
                                icon: Image.asset('assets/images/facebook.png'),
                                iconSize: 55.0,
                                onPressed: () {
                                  setState(() {
                                    signInWithFacebook();
                                    _isLogin = !_isLogin;
                                  });
                                },
                              )),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    Future<UserCredential> signInWithFacebook() async {
      final AccessToken accessToken = await FacebookAuth.instance.login();
      final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(accessToken.token);

      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

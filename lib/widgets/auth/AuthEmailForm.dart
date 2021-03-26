import 'package:activator/helper/FirebaseAuthHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:activator/models/SignInMethod.dart';

class AuthEmailForm extends StatefulWidget {
  final Function submitFn;

  AuthEmailForm(this.submitFn);

  @override
  _AuthEmailFormState createState() => _AuthEmailFormState();
}

class _AuthEmailFormState extends State<AuthEmailForm> {
  final _formKey = GlobalKey<FormState>();
  var _isPasswordVisible = false;
  var _userEmail = '';
  var _userPassword = '';
  bool _showEmailClear = false;
  bool _showPasswordView = false;

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        context,
        SignInMethod.email,
        _userEmail,
        _userPassword,
      );
      Navigator.of(context).pop();
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FocusNode emailFocus, usernameFocus, passwordFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _showLoginForm(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Please enter your credentials',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              content: Form(
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
                      textInputAction: TextInputAction.next,
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
                        labelText: 'Email address',
                        labelStyle: TextStyle(
                            color: emailFocus.hasFocus ? Color(0xff008000) : Colors.grey
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff008000), width: 2.0),
                        ),
                        suffixIcon: _emailController.text.length > 0
                            ? IconButton(
                          onPressed: () => _emailController.clear(),
                          icon: Icon(Icons.clear, color: Colors.grey),
                        )
                            : null,
                      ),
                      onSaved: (value) {
                        _userEmail = value.trim();
                      },
                      onChanged: (value) {
                        setState(() {
                          _showEmailClear = value.length > 0;
                        });
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
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: passwordFocus.hasFocus ? Color(0xff008000) : Colors.grey
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xff008000), width: 2.0),
                        ),
                        suffixIcon: _passwordController.text.length > 0
                            ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: _isPasswordVisible ?
                          Icon(
                              Icons.visibility_off_rounded,
                              color: Colors.grey)
                         : Icon(
                          Icons.visibility_rounded,
                          color: Colors.grey,
                        ),
                        )
                        : null,
                      ),
                      obscureText: !_isPasswordVisible,
                      onSaved: (value) {
                        _userPassword = value.trim();
                      },
                      onChanged: (value) {
                        setState(() {
                          _showPasswordView = value.length > 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel', style: TextStyle(color: Color(0xff008000))),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                    child: const Text('Sign In', style: TextStyle(color: Color(0xff008000))),
                    onPressed: () {
                      _trySubmit(context);
                    }),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignInButtonBuilder(
      text: 'Sign in with Email',
      icon: Icons.email,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      onPressed: () => _showLoginForm(context),
      backgroundColor: const Color(0xff008000),
      width: 220.0,
    );
  }
}
import 'package:activator/helper/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignUpEmailForm extends StatefulWidget {
  final Function submitFn;

  SignUpEmailForm(this.submitFn);

  @override
  _SignUpEmailFormState createState() => _SignUpEmailFormState();
}

class _SignUpEmailFormState extends State<SignUpEmailForm> {
  final _formKey = GlobalKey<FormState>();
  var _isPasswordVisible = false;

  // var _userEmail, _userName, _userPassword = '';
  bool _showEmailClear, _showUserNameClear, _showPasswordView = false;

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

  // void createNewUser(BuildContext context) {
  //   final isValid = _formKey.currentState.validate();
  //   FocusScope.of(context).unfocus();
  //
  //   if (isValid) {
  //     showAlert(context);
  //     // _formKey.currentState.save();
  //     widget.submitFn(
  //         context,
  //         FirebaseHelper().createNewUser(_emailController.toString(), _usernameController, _passwordController)
  //     );
  //   }
  // }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text("Verification email"),
            content: Text("Check and verification your email."),
            actions: [
              TextButton(
                child: const Text('OK', style: TextStyle(color: Color(0xff008000))),
                onPressed: () => Navigator.of(context).pop()
              ),
            ]
        )
    );
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
                      // onSaved: (value) {
                      //   _userEmail = value.trim();
                      // },
                      onChanged: (value) {
                        setState(() {
                          _showEmailClear = value.length > 0;
                        });
                      },
                    ),
                    Divider(),
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
                        // onSaved: (value) {
                        //   _userName = value.trim();
                        // },
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
                      // onSaved: (value) {
                      //   _userPassword = value.trim();
                      // },
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
                    child: const Text('Sign Up', style: TextStyle(color: Color(0xff008000))),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // createNewUser(context);
                      FirebaseHelper().createNewUser(_emailController.text, _usernameController.text, _passwordController.text, 'false');
                      showAlert(context);
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
    return TextButton(
      child: Text('Create new account',
          style: TextStyle(color: Color(0xff008000))),
          onPressed: () => _showLoginForm(context)
    );
  }
}

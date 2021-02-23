import 'package:flutter/material.dart';

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
            // Container(
            //   padding: EdgeInsets.only(
            //     left: 20,
            //     right: 20,
            //     bottom: 10,
            //   ),
            //   width: double.infinity,
            //   child: Image.asset(
            //     'assets/compoza_info.png',
            //     fit: BoxFit.fill,
            //   ),
            // ),
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
                          labelText: 'Email address',
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
                      if (!_isLogin)
                        TextFormField(
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
                            labelText: 'Username',
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
                      TextFormField(
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
                          suffixIcon: _passwordController.text.length > 0
                              ? IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye,
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
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            _isLogin ? 'Login' : 'Signup',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _trySubmit,
                        ),
                      if (!widget.isLoading)
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'I already have an account'),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        )
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
}

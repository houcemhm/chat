import 'dart:io';

import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String username,
      File? image, bool isLgin) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _username = '';
  var _email = '';
  var _password = '';
  File? _userImage;
  void _pckedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!_isLogin && _userImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('please choose a photo!!'),
        backgroundColor: Theme.of(context).errorColor,
      ));

      return null;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_email.trim(), _password.trim(), _username.trim(),
          _userImage, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) userImagePicker(_pckedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email adress !!';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _email = newValue!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email adress'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.contains(RegExp(r'[1-9]')) ||
                              value.length < 4) {
                            return "Please Enter a valid username !!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (newValue) {
                          _username = newValue!;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.length < 7) {
                          return "Password should have at least 7  caracters ..!!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) {
                        _password = newValue!;
                      },
                    ),
                    const SizedBox(height: 12),
                    if (widget.isLoading)
                      CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create new account'
                              : 'I alreddy have an account ')),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

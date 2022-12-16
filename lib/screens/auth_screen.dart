import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isloading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,
      File? image, bool isLogin) async {
    UserCredential authResult;
    try {
      print(isLogin);
      setState(() {
        _isloading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

// here we upload the image

        Reference ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${authResult.user!.uid}.jpg');
        await ref.putFile(image!).then((p0) => print(p0));
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({"username": username, "emai": email, "image_url": url,"isConnected":true});
      }
      setState(() {
        _isloading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isloading = false;
      });
      var message = "An error occured , please check your credentials";
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (err) {
      setState(() {
        _isloading = false;
      });
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isloading),
    );
  }
}

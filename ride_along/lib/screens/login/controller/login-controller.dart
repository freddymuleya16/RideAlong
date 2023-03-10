import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginController {
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static var buttonController = RoundedLoadingButtonController();

  static void login(BuildContext context) async {
    try {
      //buttonController.success();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      Timer(const Duration(seconds: 2), () {
        buttonController.success();
        Timer(const Duration(milliseconds: 1500), () {});
      });
    } on FirebaseAuthException catch (e) {
      Timer(const Duration(seconds: 2), () {
        buttonController.error();
        Timer(const Duration(seconds: 2), () {
          buttonController.reset();
          print({"fff1", buttonController.currentState});
        });
      });

      print({"fff", buttonController.currentState});
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Email or Password.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    }
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegistationController {
  static final firstnameController = TextEditingController();

  static final surnameController = TextEditingController();

  static final emailController = TextEditingController();

  static final passwordController = TextEditingController();

  static final confirmPasswordController = TextEditingController();
  static var formKey = GlobalKey<FormState>();

  static var btn = RoundedLoadingButtonController();

  //static final BuildContext context;

  //RegistationController({required this.context});

  static void register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      Timer(const Duration(seconds: 2), () {
        btn.error();
        Timer(const Duration(seconds: 2), () {
          btn.reset();
        });
      });
      return;
    }
    UserCredential? userCredential;
    try {
      if (confirmPasswordController.text != passwordController.text) {
        throw FirebaseAuthException(code: 'confirm-password-does-not-match');
      }
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      var login = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      userCredential.user!.updateDisplayName(
          '${firstnameController.text} ${surnameController.text}');
      await createUserFirestored(
          userCredential.user!.uid,
          firstnameController.text,
          surnameController.text,
          emailController.text);
      Timer(const Duration(seconds: 2), () {
        btn.success();
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
          // Navigator.pushReplacementNamed(context, loginRoute);
        });
      });
      //Navigator.of(context).pop();
      //;
    } on FirebaseAuthException catch (e) {
      print({"Freddy Error", e});

      debugPrint(e.toString());
      userCredential?.user?.delete();

      Timer(const Duration(seconds: 2), () {
        btn.error();
        Timer(const Duration(seconds: 2), () {
          btn.reset();
        });
      });
      //Navigator.pop(context);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      } else if (e.code == 'confirm-password-does-not-match') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Password does not match confirm password.')));
      }
    } catch (e) {
      //Navigator.pop(context);
      print({"Freddy Error", e});

      debugPrint(e.toString());
    }
  }

  static createUserFirestored(
      String id, String name, String surname, String email) async {
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'firstname': name,
      'lastname': surname,
      'phone': "",
      'email': email,
      'location': '',
      'emergency_contact': '',
      'language': 'en',
      'emergencyContact': '',
      'locationShare': '',
    });
  }

  // Define validation functions
  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required.';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    // Regex to validate password, must contain at least one uppercase letter, one lowercase letter, one number, and one special character
    RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    if (!regex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required.';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }
}

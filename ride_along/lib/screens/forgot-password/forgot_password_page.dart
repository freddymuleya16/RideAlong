import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/global-widgets/custom-input-field.dart';
import 'package:ride_along/screens/login/login.dart';
import 'package:ride_along/screens/login/widgets/login_button.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants/colors.dart';
import '../login/widgets/tree.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? _errorText;

  final emailController = TextEditingController();

  final btnController = RoundedLoadingButtonController();

  bool validateEmail(String email) {
    // Define a regular expression pattern for matching email addresses
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Use the regex pattern to test the email address
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = isDark(context);
    return Scaffold(
      backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Tree(
              isDark: _isDark,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ooops forgot your password?",
              style: GoogleFonts.ubuntu(
                  color: _isDark ? kTextColorLight : kBackgroundColorDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomInputField(
                isDark: _isDark,
                controller: emailController,
                name: 'Email',
                errorText: _errorText,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.ubuntu(
                              color: _isDark
                                  ? kTextColorLight
                                  : kBackgroundColorDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LoginButton(
                btnController: btnController,
                isDark: _isDark,
                title: 'Send',
                onPressed: () async {
                  try {
                    String email = emailController.text;
                    if (!validateEmail(email)) {
                      // Show an error message to the user
                      throw FirebaseAuthException(
                          code: 'invalid-email',
                          message: 'Please enter a valid email address.');
                    } else {
                      // Proceed with submitting the form
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailController.text);

                      Timer(const Duration(seconds: 2), () {
                        btnController.success();
                        Timer(const Duration(seconds: 2), () {
                          btnController.reset();
                          Navigator.pop(context);
                        });
                      });
                    }
                  } on FirebaseAuthException catch (e) {
                    Timer(const Duration(seconds: 2), () {
                      btnController.error();
                      Timer(const Duration(seconds: 2), () {
                        btnController.reset();
                      });
                    });
                    if (e.code == 'invalid-email') {
                      setState(() {
                        _errorText = e.message;
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.message}')));
                  } catch (e) {
                    //Navigator.pop(context);
                    print({"Freddy Error", e});

                    debugPrint(e.toString());
                  }
                }),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      )),
    );
  }
}

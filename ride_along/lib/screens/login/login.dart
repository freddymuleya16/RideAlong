import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/global-widgets/animate-widget.dart';
import 'package:ride_along/screens/Registration/RegistrationScreen.dart';
import 'package:ride_along/screens/forgot-password/forgot_password_page.dart';
import 'package:ride_along/screens/login/controller/login-controller.dart';
import 'package:ride_along/global-widgets/custom-input-field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants/colors.dart';
import '../../constants/types.dart';
import '../../models/set-system-overlay-style.dart';
import 'widgets/login_button.dart';
import '../../global-widgets/squire_tile.dart';
import 'widgets/tree.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = true; // brightnessValue == Brightness.dark;
    _isDark
        ? setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
        : setSystemUIOverlayStyle(
            systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
    return Scaffold(
      backgroundColor: _isDark ? kDarkBackgroundColor : kBackgroundColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              AnimateWidget(seconds: 1, child: Tree(isDark: _isDark)),
              const SizedBox(
                height: 10,
              ),
              AnimateWidget(
                seconds: 2,
                child: Text(
                  "Welcome back you've been missed!",
                  style: GoogleFonts.ubuntu(
                      color: _isDark ? Colors.white : kSecondaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AnimateWidget(
                seconds: 3,
                child: CustomInputField(
                    isDark: _isDark,
                    name: "Email",
                    controller: LoginController.email),
              ),
              const SizedBox(
                height: 10,
              ),
              AnimateWidget(
                seconds: 4,
                child: CustomInputField(
                  isDark: _isDark,
                  name: "Password",
                  obscure: true,
                  controller: LoginController.password,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              AnimateWidget(
                seconds: 5,
                child: Padding(
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
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            child: Text(
                              "Forgot password?",
                              style: GoogleFonts.ubuntu(
                                  color:
                                      _isDark ? Colors.white : kSecondaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AnimateWidget(
                seconds: 6,
                child: LoginButton(
                    title: "Login",
                    isDark: _isDark,
                    onPressed: () {
                      LoginController.login(context);
                    },
                    btnController: LoginController.buttonController),
              ),
              //Mybutton(onTap: signUserIn, btnText: 'Sign In'),
              const SizedBox(
                height: 25,
              ),
              AnimateWidget(
                seconds: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.ubuntu(
                              color: _isDark ? Colors.white : kSecondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AnimateWidget(
                seconds: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquireTile(
                      imagePath: 'assets/images/google.png',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SquireTile(imagePath: 'assets/images/apple.png')
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AnimateWidget(
                seconds: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: GoogleFonts.ubuntu(
                          color: _isDark
                              ? Colors.white.withOpacity(0.75)
                              : kDarkBackgroundColor.withOpacity(0.75),
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationSCreen()));
                        },
                        child: Text(
                          "Register now!",
                          style: GoogleFonts.ubuntu(
                              color: _isDark ? Colors.white : kSecondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

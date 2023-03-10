import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/is_dark.dart';
import 'package:ride_along/global-widgets/animate-widget.dart';
import 'package:ride_along/screens/Registration/controllers/registration-controller.dart';
import 'package:ride_along/screens/login/widgets/login_button.dart';
import 'package:ride_along/screens/login/widgets/tree.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants/colors.dart';
import '../../constants/set-system-overlay-style.dart';
import '../../constants/types.dart';
import '../../global-widgets/custom-input-field.dart';
import '../../global-widgets/squire_tile.dart';
import 'widget/registration_text_field.dart';

class RegistrationSCreen extends StatefulWidget {
  const RegistrationSCreen({super.key});

  @override
  State<RegistrationSCreen> createState() => _RegistrationSCreenState();
}

class _RegistrationSCreenState extends State<RegistrationSCreen> {
  bool _isDark = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final RegistationController _ = RegistationController(context: context);

    _isDark = isDark(context);

    return Scaffold(
      backgroundColor: _isDark ? kDarkBackgroundColor : kBackgroundColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: RegistationController.formKey,
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
                  seconds: 1,
                  child: Text(
                    "Welcome to Hiking Buddy",
                    style: GoogleFonts.ubuntu(
                        color: _isDark ? Colors.white : kSecondaryColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                RegistrationTextField(
                    validator: RegistationController.validateFirstName,
                    name: "First name",
                    isDark: _isDark,
                    controller: RegistationController.firstnameController),
                const SizedBox(
                  height: 25,
                ),
                RegistrationTextField(
                    validator: RegistationController.validateLastName,
                    name: "Last name",
                    isDark: _isDark,
                    controller: RegistationController.surnameController),
                const SizedBox(
                  height: 25,
                ),
                RegistrationTextField(
                    validator: RegistationController.validateEmail,
                    name: "Email",
                    isDark: _isDark,
                    controller: RegistationController.emailController),
                // MyTextField(
                //   controller: emailController,
                //   hintText: 'Email',
                //   obscureText: false,
                // ),
                const SizedBox(
                  height: 25,
                ),
                RegistrationTextField(
                  validator: RegistationController.validatePassword,
                  isDark: _isDark,
                  controller: RegistationController.passwordController,
                  name: 'Password',
                  obscure: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                RegistrationTextField(
                  validator: RegistationController.validateConfirmPassword,
                  isDark: _isDark,
                  controller: RegistationController.confirmPasswordController,
                  name: 'Confirm Password',
                  obscure: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                AnimateWidget(
                  seconds: 3,
                  child: LoginButton(
                    title: "Sign up",
                    btnController: RegistationController.btn,
                    isDark: _isDark,
                    onPressed: () {
                      RegistationController.register(context);
                    },
                  ),
                ),
                // Mybutton(onTap: signUp, btnText: 'Register'),
                const SizedBox(
                  height: 25,
                ),
                AnimateWidget(
                  seconds: 4,
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
                  seconds: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SquireTile(imagePath: 'assets/images/google.png'),
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
                  seconds: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account?",
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
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login!",
                              style: GoogleFonts.ubuntu(
                                  color:
                                      _isDark ? Colors.white : kSecondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

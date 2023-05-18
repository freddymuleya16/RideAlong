import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/models/user/user-name.dart';

class LoginButton extends StatefulWidget {
  final bool isDark;
  final String title;
  final Function()? onPressed;
  final RoundedLoadingButtonController btnController;
  const LoginButton(
      {super.key,
      required this.isDark,
      this.onPressed,
      required this.btnController,
      required this.title});
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late bool isDark;

  void _setName() async {
    // print({2, "Passed"});
    // var value =
    //     await setUserName(userName: Get.find<MainController>().userName);

    // if (value) {
    //   print({2.1, "Passed"});
    //   Timer(const Duration(seconds: 2), () {
    //     _btnController.success();
    //     Timer(const Duration(milliseconds: 1500), () {
    //       Navigator.pushReplacementNamed(context, loginRoute);
    //     });
    //   });
    // } else {
    //   print({2.2, "Passed"});
    //   Timer(const Duration(seconds: 2), () {
    //     _btnController.error();
    //     Timer(const Duration(seconds: 2), () {
    //       _btnController.reset();
    //     });
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      width: MediaQuery.of(context).size.width - 80,
      borderRadius: 5,
      height: 55,
      color: isDark ? kBackgroundColor : kBackgroundColorDark,
      successColor: Colors.greenAccent,
      errorColor: Colors.redAccent,
      controller: widget.btnController,
      onPressed: widget.onPressed,
      valueColor: isDark ? kTextColorDark : kTextColorLight,
      child: Text(widget.title,
          style: GoogleFonts.ubuntu(
              color: isDark ? kTextColorDark : kTextColorLight,
              fontSize: 20,
              fontWeight: FontWeight.w700)),
    );
  }
}

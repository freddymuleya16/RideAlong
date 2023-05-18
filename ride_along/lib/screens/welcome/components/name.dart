import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/main-controller.dart';

class WelcomeName extends StatefulWidget {
  bool isDark;
  WelcomeName({required this.isDark});
  @override
  _WelcomeNameState createState() => _WelcomeNameState();
}

class _WelcomeNameState extends State<WelcomeName> {
  late bool isDark;
  late Duration _animationSpeed;
  late double _opacity;
  late EdgeInsets _padding;

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
    _opacity = 0.0;
    _animationSpeed = const Duration(milliseconds: 666);
    _padding = const EdgeInsets.only(top: 33);

    animationController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationSpeed,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        width: MediaQuery.of(context).size.width - 80,
        height: 80,
        decoration: BoxDecoration(
          color: isDark
              ? kBackgroundColor.withOpacity(0.75)
              : kBackgroundColorDark.withOpacity(0.75),
          borderRadius: BorderRadius.circular(17.5),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? kBackgroundColor.withOpacity(0.4)
                  : kBackgroundColorDark.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: TextField(
            textAlign: TextAlign.center,
            maxLength: 25,
            style: GoogleFonts.ubuntu(
              color: isDark ? kTextColorDark : kTextColorLight,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              decorationColor: isDark ? kTextColorDark : kTextColorLight,
            ),
            cursorColor: isDark ? kTextColorDark : kTextColorLight,
            cursorHeight: 35,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
              hintStyle: GoogleFonts.ubuntu(
                  color: isDark
                      ? kBackgroundColorDark.withOpacity(0.75)
                      : kTextColorLight.withOpacity(0.75),
                  fontSize: 21.0),
              hintText: "Your nickname...",
            ),
            onChanged: (value) {},
            onTap: () {}),
      ),
    );
  }

  animationController() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    setState(() {
      _opacity = 1.0;
      _padding = EdgeInsets.zero;
    });
  }
}

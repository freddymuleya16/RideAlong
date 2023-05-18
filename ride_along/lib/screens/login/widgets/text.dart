import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';

class WelcomeText extends StatefulWidget {
  bool isDark;
  WelcomeText({required this.isDark});
  @override
  _WelcomeTextState createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  bool isDark = false;
  Duration _animationSpeed = Duration(milliseconds: 750);
  double _opacity = 0.0, _opacity2 = 0.0;
  EdgeInsets _padding = EdgeInsets.only(top: 15);

  @override
  void initState() {
    super.initState();
    setState(() {
      isDark = widget.isDark;
    });

    animationController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: _animationSpeed,
          child: AnimatedPadding(
              duration: _animationSpeed,
              padding: _padding,
              child: Text("welcome",
                  style: GoogleFonts.ubuntu(
                      color: isDark ? kBackgroundColor : kBackgroundColorDark,
                      fontWeight: FontWeight.w800,
                      fontSize: 66))),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
            child: AnimatedOpacity(
          opacity: _opacity2,
          duration: _animationSpeed,
          child: Text("By the wey, What do your friends call you?",
              style: GoogleFonts.ubuntu(
                  color: isDark
                      ? kBackgroundColor.withOpacity(0.85)
                      : kBackgroundColorDark.withOpacity(0.85),
                  fontWeight: FontWeight.w800,
                  fontSize: 15)),
        )),
      ],
    );
  }

  animationController() async {
    await Future.delayed(Duration(milliseconds: 150));
    setState(() {
      _opacity = 1.0;
      _padding = EdgeInsets.zero;
    });
    await Future.delayed(Duration(milliseconds: 1250));
    setState(() {
      _opacity2 = 1.0;
    });
  }
}

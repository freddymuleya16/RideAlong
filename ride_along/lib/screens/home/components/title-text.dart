import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/screens/home/animations.dart';

class HomeTitleText extends StatefulWidget {
  HomeTitleText({
    super.key,
  });

  @override
  State<HomeTitleText> createState() => _HomeTitleTextState();
}

class _HomeTitleTextState extends State<HomeTitleText> {
  // final HomeAnimationsController animationsController;
  MainController mainController = (MainController());

  Duration _animationDuration = const Duration(milliseconds: 750);

  bool _isDark = false;

  double titleOpacity = 0;

  EdgeInsets titlePadding = const EdgeInsets.only(top: 20, left: 25);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      titleOpacity = 1;
      titlePadding = const EdgeInsets.only(top: 10, left: 25);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    //HomeAnimationsController _ = animationsController;
    return AnimatedPadding(
      padding: titlePadding,
      duration: _animationDuration,
      child: AnimatedOpacity(
        opacity: titleOpacity,
        duration: _animationDuration,
        child: Row(
          children: [
            Text(
              "What's up, ",
              textScaleFactor: 0.8,
              style: GoogleFonts.ubuntu(
                fontSize: 35,
                color: _isDark ? kBackgroundColor : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? "",
              textScaleFactor: 0.8,
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: _isDark ? kBackgroundColor : kPrimaryColor),
            ),
            Text(
              "!",
              textScaleFactor: 0.8,
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: _isDark ? kBackgroundColor : kPrimaryColor),
            ),
            // RichText(
            //   overflow: TextOverflow.clip,
            //   textScaleFactor: 0.9,
            //   softWrap: true,
            //   text: TextSpan(
            //     text: "What's up, ",
            //     style: GoogleFonts.ubuntu(
            //       fontSize: 35,
            //       color: _isDark ? kBackgroundColor : Colors.black,
            //       fontWeight: FontWeight.w700,
            //     ),
            //     children: [
            //       TextSpan(
            //           text:
            //               FirebaseAuth.instance.currentUser?.displayName ?? "",
            //           style: GoogleFonts.ubuntu(
            //               fontWeight: FontWeight.w700,
            //               fontSize: 35,
            //               color: _isDark ? kBackgroundColor : kBackgroundColorDark)),
            //       const TextSpan(text: '!'),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

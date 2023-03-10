import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/screens/loading/animations.dart';

class LoadingLogo extends StatelessWidget {
  bool isDark;
  LoadingLogo({required this.isDark});
  @override
  Widget build(BuildContext context) {
    var _ = LoadingAnimationsController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _.logoOpacity,
          duration: _.animationSpeed,
          child: AnimatedPadding(
            duration: _.animationSpeed,
            padding: _.logoTextpadding,
            child: Icon(Icons.check_circle_outline_rounded,
                color: isDark ? Colors.white : kSecondaryColor,
                size: MediaQuery.of(context).size.width * 0.75),
          ),
        ),
        AnimatedOpacity(
          opacity: _.textOpacity,
          duration: _.animationSpeed,
          child: Text(
            "Tasker",
            style: GoogleFonts.ubuntu(
                color: isDark ? Colors.white : kSecondaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 30),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/screens/home/animations.dart';

class HomeFloatingButton extends StatefulWidget {
  @override
  State<HomeFloatingButton> createState() => _HomeFloatingButtonState();
}

class _HomeFloatingButtonState extends State<HomeFloatingButton> {
  Duration _duration = Duration(milliseconds: 500);
  double floatingButtonOpacity = 0;
  bool _isDark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      floatingButtonOpacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    _isDark = brightnessValue == Brightness.dark;
    // HomeAnimationsController _ = HomeAnimationsController();
    double floatingButtonOpacity = 0;

    return AnimatedOpacity(
      opacity: floatingButtonOpacity,
      duration: _duration,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, newtask_route);
        },
        child: Icon(
          Icons.add_rounded,
          size: _isDark ? 33 : 30,
          color: _isDark ? kDarkPrimaryColor : Colors.white,
        ),
        backgroundColor: _isDark ? kBackgroundColor : kSecondaryColor,
        highlightElevation: 3,
      ),
    );
  }
}

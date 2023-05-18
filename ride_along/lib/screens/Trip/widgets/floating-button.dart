import 'package:flutter/material.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/screens/home/animations.dart';

class RequestFloatingButton extends StatefulWidget {
  final onPressed;

  RequestFloatingButton({super.key, this.onPressed});

  @override
  State<RequestFloatingButton> createState() => _RequestFloatingButtonState();
}

class _RequestFloatingButtonState extends State<RequestFloatingButton> {
  Duration _duration = const Duration(milliseconds: 500);
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
        onPressed: widget.onPressed,
        backgroundColor: _isDark ? kBackgroundColor : kBackgroundColorDark,
        highlightElevation: 3,
        child: Icon(
          Icons.drive_eta,
          size: _isDark ? 33 : 30,
          color: _isDark ? kPrimaryColorDark : kTextColorLight,
        ),
      ),
    );
  }
}

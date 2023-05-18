import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/controllers/main-controller.dart';

class Tree extends StatefulWidget {
  final bool isDark;
  const Tree({super.key, required this.isDark});
  @override
  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDark = widget.isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 250,
          color: kTextColorLight,
        ),
      ],
    );
  }
}

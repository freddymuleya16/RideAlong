import 'package:flutter/material.dart';
import 'package:ride_along/constants/types.dart';

import '../models/set-system-overlay-style.dart';

bool isDark(BuildContext context) {
  final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
  bool _isDark = brightnessValue == Brightness.dark;
  _isDark
      ? setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
      : setSystemUIOverlayStyle(
          systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);

  return _isDark;
}

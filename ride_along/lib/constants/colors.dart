import 'package:flutter/material.dart';

// Shades of Purple
const Color kPrimaryColor = Color(0xFF8E44AD);
const Color kPrimaryColorDark = Color(0xFF5D3F6A);
const Color kPrimaryColorLight = Color(0xFFC39BD3);

// Accent Colors
const Color kAccentColor1 = Color(0xFF9B59B6);
const Color kAccentColor2 = Color(0xFFBE90D4);
const Color kAccentColor3 = Color(0xFFE8DAEF);

// Text Colors
const Color kTextColorDark = Color(0xFF2C3E50);
const Color kTextColorLight = Color(0xFFECF0F1);

// Background Colors
const Color kBackgroundColor = Color(0xFFF5F6FA);
const Color kBackgroundColorDark = Color(0xFF17202A);

class PrimaryColor extends MaterialStateColor {
  const PrimaryColor() : super(_defaultColor);

  static const int _defaultColor = 0xff0E1F55;
  static const int _pressedColor = 0xff0E1F55;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}

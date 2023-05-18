// import 'package:flutter/material.dart';
// import 'package:ride_along/constants/colors.dart';
// import 'package:ride_along/constants/set-system-overlay-style.dart';
// import 'package:ride_along/constants/types.dart';
// import 'package:ride_along/screens/welcome/components/text.dart';

// import 'components/button.dart';
// import 'components/name.dart';

// class WelcomeScreen extends StatelessWidget {
//   bool _isDark = false;
//   @override
//   Widget build(BuildContext context) {
//     final Brightness brightnessValue =
//         MediaQuery.of(context).platformBrightness;
//     _isDark = brightnessValue == Brightness.dark;
//     _isDark
//         ? setSystemUIOverlayStyle(
//             systemUIOverlayStyle: SystemUIOverlayStyle.DARK)
//         : setSystemUIOverlayStyle(
//             systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
//     return Scaffold(
//         backgroundColor: _isDark ? kBackgroundColorDark : kBackgroundColor,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(),
//             const SizedBox(),
//             Center(child: WelcomeText(isDark: _isDark)),
//             const SizedBox(),
//             const SizedBox(),
//             const SizedBox(),
//             Center(
//               child: WelcomeName(isDark: _isDark),
//             ),
//             const SizedBox(),
//             const SizedBox(),
//             const SizedBox(),
//             LoadingButton(isDark: _isDark),
//             const SizedBox(),
//             const SizedBox(),
//           ],
//         ));
//   }
// }

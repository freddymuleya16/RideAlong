// import 'dart:async';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:ride_along/constants/colors.dart';
// import 'package:ride_along/constants/routes.dart';
// import 'package:ride_along/controllers/main-controller.dart';
// import 'package:ride_along/models/user/user-name.dart';

// class LoadingButton extends StatefulWidget {
//   final bool isDark;
//   const LoadingButton({super.key, required this.isDark});
//   @override
//   _LoadingButtonState createState() => _LoadingButtonState();
// }

// class _LoadingButtonState extends State<LoadingButton> {
//   late bool isDark;
//   late Duration _animationSpeed;
//   late double _opacity;

//   final RoundedLoadingButtonController _btnController =
//       RoundedLoadingButtonController();

//   void _setName() async {
//     print({2, "Passed"});
//     //var value =
//     //    await setUserName(userName: MainController>().userName);

//     //if (value) {
//       print({2.1, "Passed"});
//       Timer(const Duration(seconds: 2), () {
//         _btnController.success();
//         Timer(const Duration(milliseconds: 1500), () {
//           Navigator.pushReplacementNamed(context, loginRoute);
//         });
//       });
//     //} else {
//       print({2.2, "Passed"});
//       Timer(const Duration(seconds: 2), () {
//         _btnController.error();
//         Timer(const Duration(seconds: 2), () {
//           _btnController.reset();
//         });
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     isDark = widget.isDark;
//     _opacity = 0.0;
//     _animationSpeed = const Duration(milliseconds: 500);

//     animationController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       opacity: _opacity,
//       duration: _animationSpeed,
//       child: RoundedLoadingButton(
//         height: 55,
//         color: isDark ? kBackgroundColor : kSecondaryColor,
//         successColor: Colors.greenAccent,
//         errorColor: Colors.redAccent,
//         controller: _btnController,
//         onPressed: _setName,
//         valueColor: isDark ? kDarkBackgroundColor : Colors.white,
//         child: Text('continue',
//             style: GoogleFonts.ubuntu(
//                 color: isDark ? kDarkBackgroundColor : Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700)),
//       ),
//     );
//   }

//   animationController() async {
//     await Future.delayed(const Duration(milliseconds: 5555));
//     setState(() {
//       _opacity = 1.0;
//     });
//   }
// }

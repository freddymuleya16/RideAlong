// import 'package:flutter/material.dart';

// import 'package:ride_along/constants/colors.dart';
// import 'package:ride_along/constants/routes.dart';
// import 'package:ride_along/constants/task-colors.dart';
// import 'package:ride_along/constants/types.dart';
// import 'package:ride_along/models/set-system-overlay-style.dart';
// import 'package:ride_along/screens/new-task/animations.dart';
// import 'package:ride_along/screens/new-task/animations.dart';
// import 'package:ride_along/screens/new-task/components/button.dart';
// import 'package:ride_along/screens/new-task/components/close.dart';
// import 'package:ride_along/controllers/new-task/newtask-controller.dart';
// import 'package:ride_along/screens/new-task/components/setup.dart';

// class NewTaskScreen extends StatelessWidget {
//   NewTaskController newTaskController = (NewTaskController());
//   NewTaskAnimationsController newTaskAnimationsController = (
//     NewTaskAnimationsController(),
//   );
//   bool _isDark = false;
//   @override
//   Widget build(BuildContext context) {
//     final Brightness brightnessValue =
//         MediaQuery.of(context).platformBrightness;
//     _isDark = brightnessValue == Brightness.dark;
//     _isDark
//         ? setSystemUIOverlayStyle(
//             systemUIOverlayStyle: SystemUIOverlayStyle.BLUE_DARK)
//         : setSystemUIOverlayStyle(
//             systemUIOverlayStyle: SystemUIOverlayStyle.LIGHT);
//     startAnimations();
//     return WillPopScope(
//       onWillPop: () async {
//         return await closePage(context);
//       },
//       child: Scaffold(
//         backgroundColor: _isDark ? kDarkBackgroundColor2 : Colors.white,
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [NewTaskCloseButton(), NewTaskSetup(), NewTaskButton()],
//           ),
//         ),
//       ),
//     );
//   }

//   Future closePage(BuildContext context) async {
//     await NewTaskController>()
//         .updateNewTask(newColor: color1, newColorNum: 0, newText: "");
//     await NewTaskAnimationsController>().updateAnimations(
//         newAddButtonOpacity: 0,
//         newBox1Opacity: 0,
//         newBox2Opacity: 0,
//         newCloseButtonOpacity: 0,
//         newTextFieldOpacity: 0);
//     Navigator.pushNamed(context, home_route);
//     return null;
//   }
// }

// import 'package:flutter/cupertino.dart';

// class HomeAnimationsController {
//   // navbar:
//   double navbarOpacity1 = 0, navbarOpacity2 = 0;
//   // title:
//   double titleOpacity = 0;
//   EdgeInsets titlePadding = const EdgeInsets.only(top: 20, left: 25);
//   // tasks:
//   double tasksTitleOpacity = 0;
//   double notFoundOpacity = 0;
//   // floating button:
//   double floatingButtonOpacity = 0;

//   // update void
//   updateHomeAnimations(
//       {double? newNavbarOpacity1,
//       double? newNavbarOpacity2,
//       double? newTitleOpacity,
//       double? newTasksTitleOpacity,
//       double? newNotFoundOpacity,
//       double? newFloatingButtonOpacity,
//       EdgeInsets? newTitlePadding}) {
//     navbarOpacity1 = newNavbarOpacity1 ?? navbarOpacity1;
//     navbarOpacity2 = newNavbarOpacity2 ?? navbarOpacity2;
//     titleOpacity = newTitleOpacity ?? titleOpacity;
//     tasksTitleOpacity = newTasksTitleOpacity ?? tasksTitleOpacity;
//     notFoundOpacity = newNotFoundOpacity ?? notFoundOpacity;
//     floatingButtonOpacity = newFloatingButtonOpacity ?? floatingButtonOpacity;
//     titlePadding = newTitlePadding ?? titlePadding;
//   }
// }

// startHomeAnimations(
//     {required HomeAnimationsController homeAnimationsController}) async {
//   print("object");
//   await Future.delayed(const Duration(milliseconds: 500));
//   homeAnimationsController.updateHomeAnimations(
//     newNavbarOpacity1: 1,
//   );
//   await Future.delayed(const Duration(milliseconds: 200));
//   homeAnimationsController.updateHomeAnimations(
//     newNavbarOpacity2: 1,
//   );
//   await Future.delayed(const Duration(milliseconds: 500));
//   homeAnimationsController.updateHomeAnimations(
//     newTitleOpacity: 1,
//     newTitlePadding: const EdgeInsets.only(top: 10, left: 25),
//   );
//   await Future.delayed(const Duration(milliseconds: 500));
//   homeAnimationsController.updateHomeAnimations(
//     newTasksTitleOpacity: 1,
//   );
//   await Future.delayed(const Duration(milliseconds: 500));
//   homeAnimationsController.updateHomeAnimations(
//     newNotFoundOpacity: 1,
//   );
//   await Future.delayed(const Duration(milliseconds: 500));
//   homeAnimationsController.updateHomeAnimations(
//     newFloatingButtonOpacity: 1,
//   );
// }

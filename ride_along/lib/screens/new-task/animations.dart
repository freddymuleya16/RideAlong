
//   double closeButtonOpacity = 0;
//   double textFieldOpacity = 0;
//   double box1Opacity = 0;
//   double box2Opacity = 0;
//   double addButtonOpacity = 0;

//   updateAnimations(
//       {double? newCloseButtonOpacity,
//       double? newTextFieldOpacity,
//       double? newBox1Opacity,
//       double? newBox2Opacity,
//       double? newAddButtonOpacity}) {
//     closeButtonOpacity = newCloseButtonOpacity ?? closeButtonOpacity;
//     textFieldOpacity = newTextFieldOpacity ?? textFieldOpacity;
//     box1Opacity = newBox1Opacity ?? box1Opacity;
//     box2Opacity = newBox2Opacity ?? box2Opacity;
//     addButtonOpacity = newAddButtonOpacity ?? addButtonOpacity;
//     update();
//   }
// }

// startAnimations() async {
//   await Future.delayed(const Duration(milliseconds: 250));
//   NewTaskAnimationsController>()
//       .updateAnimations(newCloseButtonOpacity: 1);
//   await Future.delayed(const Duration(milliseconds: 250));
//   NewTaskAnimationsController>()
//       .updateAnimations(newTextFieldOpacity: 1);
//   await Future.delayed(const Duration(milliseconds: 250));
//   NewTaskAnimationsController>().updateAnimations(newBox1Opacity: 1);
//   NewTaskAnimationsController>().updateAnimations(newBox2Opacity: 1);
//   await Future.delayed(const Duration(milliseconds: 750));
//   NewTaskAnimationsController>()
//       .updateAnimations(newAddButtonOpacity: 1);
// }

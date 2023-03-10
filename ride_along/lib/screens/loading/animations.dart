import 'package:flutter/material.dart';

class LoadingAnimationsController {
  double logoOpacity = 0, textOpacity = 0, spinkitOpacity = 0;
  EdgeInsets logoTextpadding = const EdgeInsets.only(top: 33);
  Duration animationSpeed = const Duration(milliseconds: 666);
  Duration allAnimationTimes = const Duration(milliseconds: 4000);

  updateLoadingAnimations(
      {double? newLogoOpacity,
      double? newTextOpacity,
      double? newSpinkitOpacity,
      EdgeInsets? newLogoTextPadding}) {
    logoOpacity = newLogoOpacity ?? logoOpacity;
    textOpacity = newTextOpacity ?? textOpacity;
    spinkitOpacity = newSpinkitOpacity ?? spinkitOpacity;
    logoTextpadding = newLogoTextPadding ?? logoTextpadding;
  }
}

startLoadingAnimations() async {
  await Future.delayed(const Duration(milliseconds: 500));
  LoadingAnimationsController().updateLoadingAnimations(
      newLogoOpacity: 1, newLogoTextPadding: EdgeInsets.zero);
  await Future.delayed(const Duration(milliseconds: 1000));
  LoadingAnimationsController().updateLoadingAnimations(newTextOpacity: 1);
  await Future.delayed(const Duration(milliseconds: 250));
  LoadingAnimationsController().updateLoadingAnimations(newSpinkitOpacity: 1);
  await Future.delayed(const Duration(milliseconds: 2000));
  LoadingAnimationsController().updateLoadingAnimations(
      newLogoOpacity: 0,
      newTextOpacity: 0,
      newSpinkitOpacity: 0,
      newLogoTextPadding: const EdgeInsets.only(top: 33));
}

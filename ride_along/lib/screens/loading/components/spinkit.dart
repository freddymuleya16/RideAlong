import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/screens/loading/animations.dart';

class LoadingSpinkit extends StatelessWidget {
  final bool isDark;
  const LoadingSpinkit({super.key, required this.isDark});
  @override
  Widget build(BuildContext context) {
    var _ = LoadingAnimationsController();

    return AnimatedOpacity(
      opacity: _.spinkitOpacity,
      duration: const Duration(milliseconds: 666),
      child: SpinKitWave(
        color: isDark ? kTextColorLight : kBackgroundColorDark,
        size: 30,
      ),
    );
  }
}

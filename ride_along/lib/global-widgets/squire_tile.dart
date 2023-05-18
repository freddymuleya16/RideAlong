import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ride_along/constants/colors.dart';

class SquireTile extends StatelessWidget {
  final String imagePath;
  final double imageHeight;
  final Function()? onTap;

  const SquireTile({
    super.key,
    required this.imagePath,
    this.onTap,
    this.imageHeight = 40,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: kTextColorLight),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16)),
              child: Image.asset(
                imagePath,
                height: imageHeight,
              ),
            )));
  }
}

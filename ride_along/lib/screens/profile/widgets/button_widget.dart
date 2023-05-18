import 'package:flutter/material.dart';
import 'package:ride_along/constants/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          onPrimary: kTextColorLight,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

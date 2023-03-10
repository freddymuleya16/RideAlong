import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyButton extends StatelessWidget {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      child: Text('Click me'),
      controller: _controller,
      onPressed: () {
        _controller.start();
        // Do some work
        Future.delayed(Duration(seconds: 2), () {
          _controller.stop();
        });
      },
    );
  }
}

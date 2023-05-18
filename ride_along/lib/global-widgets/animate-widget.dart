import 'dart:async';

import 'package:flutter/material.dart';

class AnimateWidget extends StatefulWidget {
  final int seconds;
  final Widget? child;

  const AnimateWidget({Key? key, required this.seconds, this.child})
      : super(key: key);

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget> {
  Duration _animationDuration = const Duration(seconds: 750);
  double _opacity = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationDuration = Duration(seconds: widget.seconds);

    _timer = Timer(Duration(seconds: widget.seconds), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it is active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationDuration,
      child: widget.child,
    );
  }
}

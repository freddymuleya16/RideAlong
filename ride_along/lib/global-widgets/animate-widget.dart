import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AnimateWidget extends StatefulWidget {
  final int seconds;

  final Widget? child;

  const AnimateWidget({super.key, required this.seconds, this.child});

  @override
  State<AnimateWidget> createState() => _AnimateWidgetState();
}

class _AnimateWidgetState extends State<AnimateWidget> {
  Duration _animationDuration = const Duration(seconds: 750);

  double _opacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationDuration = Duration(seconds: widget.seconds);

    Timer(Duration(seconds: widget.seconds), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: _opacity, duration: _animationDuration, child: widget.child);
  }
}

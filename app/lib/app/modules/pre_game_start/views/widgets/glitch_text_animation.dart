import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class GlitchTextAnimation extends StatefulWidget {
  @override
  _GlitchTextAnimationState createState() => _GlitchTextAnimationState();
}

class _GlitchTextAnimationState extends State<GlitchTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  late double _offsetX;
  late double _offsetY;
  bool isTextVisible = true;

  void _toggleVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  void _startToggleTimer() {
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      _toggleVisibility();
      _startToggleTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    _startToggleTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      if (_controller.status == AnimationStatus.completed ||
          _controller.status == AnimationStatus.forward) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });

    _offsetX = Random().nextDouble() * 20;
    _offsetY = Random().nextDouble() * 20;
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.skewX(0)
              ..translate(
                _offsetX * _controller.value,
                _offsetY * _controller.value,
              ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: isTextVisible
                  ? Text(
                      'PRESS TO\nSTART',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  : Image.asset(
                      'assets/images/press_to_start.gif',
                      width: 300,
                    ),
            ),
          );
        },
      ),
    );
  }
}

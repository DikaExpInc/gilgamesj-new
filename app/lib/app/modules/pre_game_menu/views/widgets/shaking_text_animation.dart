import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class ShakingTextAnimation extends StatefulWidget {
  final String initialText;
  final String url;
  final String image;
  final int duration;
  final double width;

  ShakingTextAnimation({
    required this.initialText,
    required this.url,
    required this.image,
    required this.duration,
    required this.width,
  });

  @override
  _ShakingTextAnimationState createState() => _ShakingTextAnimationState();
}

class _ShakingTextAnimationState extends State<ShakingTextAnimation> {
  bool isTextVisible = true;

  void _toggleVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _startToggleTimer();
  }

  void _startToggleTimer() {
    Timer.periodic(
      Duration(seconds: widget.duration),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        _toggleVisibility();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.url != ""
        ? Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isTextVisible
                    ? InkWell(
                        onTap: () {
                          Get.toNamed(widget.url);
                        },
                        child: Text(
                          '${widget.initialText}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Get.toNamed(widget.url);
                        },
                        child: Image.asset(
                          '${widget.image}',
                          width: widget.width,
                          height: 45, // Path to your GIF image
                        ),
                      ),
              ),
            ],
          )
        : Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: isTextVisible
                    ? Text(
                        '${widget.initialText}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    : Image.asset(
                        '${widget.image}',
                        width: widget.width,
                        height: 45, // Path to your GIF image
                      ),
              ),
            ],
          );
  }
}

import 'package:flutter/material.dart';

@immutable
class CircleUIConfig {
  final Color fillColor;
  final double borderWidth;
  final double circleSize;

  const CircleUIConfig({
    this.borderWidth = 1,
    this.fillColor = Colors.white,
    this.circleSize = 20,
  });
}

class CircleMusic extends StatelessWidget {
  final bool filled;
  final Color colorBorder;
  final Color colorFill;
  final CircleUIConfig circleUIConfig;
  final double extraSize;

  CircleMusic({
    Key? key,
    this.filled = false,
    required this.colorBorder,
    required this.colorFill,
    required this.circleUIConfig,
    this.extraSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: extraSize),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
        color: filled ? colorFill : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: colorBorder,
          width: circleUIConfig.borderWidth,
        ),
      ),
    );
  }
}

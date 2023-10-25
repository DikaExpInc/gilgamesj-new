import 'package:flutter/material.dart';

class PulsatingOpacityOverlay extends StatefulWidget {
  @override
  _PulsatingOpacityOverlayState createState() =>
      _PulsatingOpacityOverlayState();
}

class _PulsatingOpacityOverlayState extends State<PulsatingOpacityOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _animationController.value *
              0.5, // Adjust the opacity range (0.0 to 0.9)
          child: child,
        );
      },
      child: Container(
        color: Colors.red,
      ),
    );
  }
}

import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_tutorial_controller.dart';

// ignore: must_be_immutable
class PreGameTutorialView extends GetView<PreGameTutorialController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
            image: AssetImage("assets/images/background3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 80,
              left: 80,
              child: GestureDetector(
                onTapDown: (_) => controller.toggleTap(1),
                onTapUp: (_) => controller.toggleTap(1, isTapped: false),
                child: SvgPicture.asset(
                  "assets/icons/finger.svg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 80,
              child: GestureDetector(
                onTap: () => controller.toggleTap(2),
                onTapUp: (_) => controller.toggleTap(2, isTapped: false),
                child: SvgPicture.asset(
                  "assets/icons/finger.svg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 80,
              child: GestureDetector(
                onTap: () => controller.toggleTap(3),
                onTapUp: (_) => controller.toggleTap(3, isTapped: false),
                child: SvgPicture.asset(
                  "assets/icons/finger.svg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 80,
              child: GestureDetector(
                onTap: () => controller.toggleTap(4),
                onTapUp: (_) => controller.toggleTap(4, isTapped: false),
                child: SvgPicture.asset(
                  "assets/icons/finger.svg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Text(
                  'Press on the 4 points together\nto enter spirit realm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

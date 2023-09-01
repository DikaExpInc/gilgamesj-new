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
              child: InkWell(
                onTap: () => {Get.toNamed(Routes.PRE_GAME_SPIRIT_REALM)},
                child: SvgPicture.asset("assets/icons/finger.svg"),
              ),
            ),
            Positioned(
              top: 80,
              right: 80,
              child: SvgPicture.asset("assets/icons/finger.svg"),
            ),
            Positioned(
              bottom: 80,
              left: 80,
              child: SvgPicture.asset("assets/icons/finger.svg"),
            ),
            Positioned(
              bottom: 80,
              right: 80,
              child: SvgPicture.asset("assets/icons/finger.svg"),
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

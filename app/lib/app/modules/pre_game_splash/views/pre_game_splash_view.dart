import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_splash_controller.dart';

class PreGameSplashView extends GetView<PreGameSplashController> {
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
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              curve: Curves.easeIn,
              parent: controller.fadeAnimationController,
            )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "made by",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.asset('assets/images/logo_color.png'),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                      controller.images[controller.currentImageIndex.value]),
                  Text(
                    'www.expinc.io',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

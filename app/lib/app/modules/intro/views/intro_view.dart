import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  late double mWidth;
  late double mHeight;

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: mWidth / 10),
                      child: Text(
                        "INTRODUCTIE",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      // onTap: () => {Get.toNamed(Routes.PRE_GAME_ITEMS)},
                      onTap: () => {Get.toNamed(Routes.PRE_GAME_SPLASH)},
                      child: Image.asset("assets/images/ic_back.png"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Center(
                      child: Image.asset('assets/images/voice_actor.png')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: mWidth * 1.4, // Lebar 100%
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child:
                              SvgPicture.asset("assets/images/rectangle.svg"),
                        ),
                        Positioned(
                          bottom: 40,
                          right: 40,
                          child:
                              SvgPicture.asset("assets/icons/sound_icon.svg"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

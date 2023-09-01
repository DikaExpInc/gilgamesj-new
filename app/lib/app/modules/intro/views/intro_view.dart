import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/intro_controller.dart';

// ignore: must_be_immutable
class IntroView extends GetView<IntroController> {
  // late double mWidth;
  // late double mHeight;

  // Orientation getScreenOrientation(BuildContext context) {
  //   return MediaQuery.of(context).orientation;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   mWidth = MediaQuery.of(context).size.width;
  //   mHeight = MediaQuery.of(context).size.height;
  //   return Scaffold(
  //     body: Container(
  //       width: mWidth,
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage("assets/images/background2.png"),
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 50),
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(left: mWidth / 10),
  //                     child: Text(
  //                       "INTRODUCTIE",
  //                       style: TextStyle(
  //                         fontSize: 48,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     ),
  //                   ),
  //                   InkWell(
  //                     // onTap: () => {Get.toNamed(Routes.PRE_GAME_ITEMS)},
  //                     onTap: () => {Get.toNamed(Routes.PRE_GAME_ITEMS)},
  //                     child: Image.asset("assets/images/ic_back.png"),
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 70),
  //                 child: Center(
  //                     child: Image.asset('assets/images/voice_actor.png')),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 70),
  //                 child: Center(
  //                   child: Stack(
  //                     children: [
  //                       Container(
  //                         width: mWidth * 1.4, // Lebar 100%
  //                         padding: EdgeInsets.symmetric(vertical: 20.0),
  //                         child:
  //                             SvgPicture.asset("assets/images/rectangle.svg"),
  //                       ),
  //                       Positioned(
  //                         bottom: 40,
  //                         right: 40,
  //                         child:
  //                             SvgPicture.asset("assets/icons/sound_icon.svg"),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          controller.rotatingParticle,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              controller.rotatingImage,
              DefaultTextStyle(
                style: const TextStyle(
                  fontFamily: 'Centrion',
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('It is not enough to do your best,'),
                    TyperAnimatedText('you must know what to do,'),
                    TyperAnimatedText('and then do your best'),
                    TyperAnimatedText('It is not enough to do your best,'),
                    TyperAnimatedText('you must know what to do,'),
                    TyperAnimatedText('and then do your best'),
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    // Navigate to the next page here
                    Get.offAndToNamed(Routes
                        .PRE_GAME_ITEMS); // Replace with your navigation code
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/pre_game_success_controller.dart';

class PreGameSuccessView extends GetView<PreGameSuccessController> {
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
              Stack(
                children: [
                  controller.rotatingImage,
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Text(
                      "de tablethouder is ${GetStorage().read('played_name_${GetStorage().read('played_number')}')}",
                      style: TextStyle(
                        fontFamily: 'Centrion',
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    right: mWidth / 3,
                    top: mHeight / 3.5,
                    child: Text(
                      "GEHAALD",
                      style: TextStyle(
                        fontFamily: 'Centrion',
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

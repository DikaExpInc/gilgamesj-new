import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_start_controller.dart';

// ignore: must_be_immutable
class PreGameStartView extends GetView<PreGameStartController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: InkWell(
      onTap: () => Get.toNamed(Routes.PRE_GAME_MENU),
      child: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.0), BlendMode.srcOver),
            image: AssetImage("assets/images/background3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/logo_color.png'),
                    ),
                    Text(
                      "www.expinc.io",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'PRESS TO\nSTART',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    ));
  }
}

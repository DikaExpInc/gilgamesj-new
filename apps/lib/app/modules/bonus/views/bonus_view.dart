import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/bonus/controllers/bonus_controller.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';

class BonusView extends GetView<BonusController> {
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
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/bonus_icon.png'),
                SizedBox(
                  height: 42,
                ),
                Text(
                  "BONUS LEVEL",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Text(
                  "Please head through out the Theater to to Play the Game.\nPress “READY”  when your team is outside and ready to play.",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () => {
                Get.back(),
                Get.toNamed(
                  Routes.BONUS_HOME_SCREEN,
                ),
              },
              child: Container(
                width: mWidth / 4,
                padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal:
                        MediaQuery.of(context).size.width > 600 ? 50 : 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_btn.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "READY",
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 16 : 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

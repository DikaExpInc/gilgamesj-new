import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/pre_game_items_controller.dart';

// ignore: must_be_immutable
class PreGameItemsView extends GetView<PreGameItemsController> {
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
                      padding: EdgeInsets.only(left: mWidth / 3),
                      child: Text(
                        "DE MUSEUMSTUKKEN",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {Get.toNamed(Routes.PRE_GAME_RUNE)},
                      child: Image.asset("assets/images/ic_rune.png"),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: GridView.count(
                      crossAxisCount: 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(12, (index) {
                        return Container(
                          margin: EdgeInsets.all(20.0),
                          child:
                              Image.asset("assets/images/tile${index + 1}.png"),
                        );
                      }),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => {},
                        child: Container(
                          width: mWidth / 4,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal:
                                  MediaQuery.of(context).size.width > 600
                                      ? 50
                                      : 20),
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
                                "DOORGAN",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 16
                                          : 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

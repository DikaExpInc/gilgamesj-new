import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_items_ar_controller.dart';

// ignore: must_be_immutable
class PreGameItemsArView extends GetView<PreGameItemsArController> {
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
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Container(
            child: Stack(children: [
              controller.rotatingParticle,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "DE MUSEUMSTUKKEN",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        // "Richt de camera op de QR-code / AR-object.",
                        "Vind het symbool en de bijbehorende code op het museumstuk",
                        style: TextStyle(
                          fontFamily: 'Abel',
                          fontSize: 32,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Obx(
                        () => GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(4, (index) {
                            // final box = GetStorage();
                            switch (index) {
                              case 0:
                                index = 3;
                                break;
                              case 1:
                                index = 4;
                                break;
                              case 2:
                                index = 5;
                                break;
                              case 3:
                                index = 7;
                                break;
                              default:
                            }

                            final isSelected =
                                index == controller.selectedItemIndex.value;

                            return GestureDetector(
                              onTap: () {
                                controller.selectedItemIndex.value =
                                    isSelected ? -1 : index;
                              },
                              child: Container(
                                margin: EdgeInsets.all(mWidth / 40.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue.shade400
                                        : Colors.transparent,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: controller.isKeyExistsInGetStorage(
                                        "pre-game-${index + 1}")
                                    ? Image.asset(
                                        "assets/images/tile${index + 1}-complete.png",
                                      )
                                    : Image.asset(
                                        "assets/images/tile${index + 1}.png",
                                      ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.selectedItemIndex.value != 0
                        ? Center(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => {controller.onSubmit()},
                                  child: Container(
                                    width: mWidth / 4,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal:
                                            MediaQuery.of(context).size.width >
                                                    600
                                                ? 50
                                                : 20),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/bg_btn.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "DOORGAAN",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    600
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
                          )
                        : Container(),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

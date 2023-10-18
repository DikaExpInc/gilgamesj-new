import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
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
    return GetBuilder<PreGameItemsController>(builder: (controller) {
      return Scaffold(
        body: Container(
          width: mWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background4.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Obx(
                () => !controller.isPositionedVisible.value
                    ? Positioned(
                        top: 40,
                        left: 40,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleTap(1),
                            onTapUp: (_) =>
                                controller.toggleTap(1, isTapped: false),
                            child: controller.tappedList[0]
                                ? SvgPicture.asset(
                                    "assets/icons/finger-active.svg",
                                    width: 100,
                                    height: 100,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/finger.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Obx(
                () => !controller.isPositionedVisible.value
                    ? Positioned(
                        top: 40,
                        right: 40,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleTap(2),
                            onTapUp: (_) =>
                                controller.toggleTap(2, isTapped: false),
                            child: controller.tappedList[1]
                                ? SvgPicture.asset(
                                    "assets/icons/finger-active.svg",
                                    width: 100,
                                    height: 100,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/finger.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Obx(
                () => !controller.isPositionedVisible.value
                    ? Positioned(
                        bottom: 40,
                        left: 40,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleTap(3),
                            onTapUp: (_) =>
                                controller.toggleTap(3, isTapped: false),
                            child: controller.tappedList[2]
                                ? SvgPicture.asset(
                                    "assets/icons/finger-active.svg",
                                    width: 100,
                                    height: 100,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/finger.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Obx(
                () => !controller.isPositionedVisible.value
                    ? Positioned(
                        bottom: 40,
                        right: 40,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleTap(4),
                            onTapUp: (_) =>
                                controller.toggleTap(4, isTapped: false),
                            child: controller.tappedList[3]
                                ? SvgPicture.asset(
                                    "assets/icons/finger-active.svg",
                                    width: 100,
                                    height: 100,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/finger.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 80),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
                              return GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 1) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 2) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 3) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 4) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 5) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 6) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 7) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 8) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 9) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 10) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 11) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  } else if (index == 12) {
                                    controller.showItemDialog(
                                      image:
                                          "assets/images/tile${index + 1}.png",
                                      title: "Gate of Babylon",
                                      description:
                                          "Dit is een prachtig museumstuk, Ga verder en kijk ook naar de rest van ons mooie museum",
                                    );
                                  }
                                },
                                child: Container(
                                    margin: EdgeInsets.all(mWidth / 40.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Image.asset(
                                      "assets/images/tile${index + 1}.png",
                                    )),
                              );
                            }),
                          ),
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
    });
  }
}

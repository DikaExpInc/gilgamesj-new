import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/give_tablet_controller.dart';

class GiveTabletView extends GetView<GiveTabletController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<GiveTabletController>(builder: (controller) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Geef de tablet aan',
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
              ),
            ),
            Text(
              "${GetStorage().read('played_name_${GetStorage().read('played_number')}')}",
              style: TextStyle(
                fontSize: 64,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ));
    });
  }
}

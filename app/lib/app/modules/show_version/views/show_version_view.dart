import 'package:app/app/utils/app_config.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/show_version_controller.dart';

class ShowVersionView extends GetView<ShowVersionController> {
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
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(),
          Column(
            children: [
              Text(
                "V.${AppConfig().version}",
                style: TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Obx(
                () => Text(
                  "${controller.myIP.value}",
                  style: TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Center(),
        ],
      ),
    ));
  }
}

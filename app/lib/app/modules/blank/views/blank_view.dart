import 'package:app/app/modules/blank/controllers/blank_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class BlankView extends GetView<BlankController> {
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
          colorFilter: ColorFilter.mode(
              Colors.blueAccent.withOpacity(0.5), BlendMode.srcOver),
          image: AssetImage("assets/images/background2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "my name",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            "Group",
            style: TextStyle(
              fontSize: 64,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "1",
            style: TextStyle(
              fontSize: 64,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}

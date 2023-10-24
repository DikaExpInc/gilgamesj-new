import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/go_theater_controller.dart';

// ignore: must_be_immutable
class GoTheaterView extends GetView<GoTheaterController> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(),
          Column(
            children: [
              Text(
                "Ga naar het theater",
                style: TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Jullie mogen zitten op\nRij [row nr] Stoelen [chair numbers]',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Center(),
        ],
      ),
    ));
  }
}

import 'package:gilgamesj_tour/app/modules/theater_game_lightning_game_custom/controllers/theater_game_lightning_game_custom_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class LightningGameCustomLightScreen
    extends GetView<TheaterGameLightningGameCustomController> {
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
        color: Colors.white,
      ),
    );
  }
}

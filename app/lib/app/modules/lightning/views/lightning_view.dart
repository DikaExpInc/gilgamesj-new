import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/lightning_controller.dart';

class LightningView extends GetView<LightningController> {
  late double mWidth;
  late double mHeight;
  
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Obx(
          () => controller.isDone.value
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      color: Colors.white,
                    ),
                  ],
                )
              : VideoPlayer(controller.videocontroller!),
        ),
      ),
    );
  }
}

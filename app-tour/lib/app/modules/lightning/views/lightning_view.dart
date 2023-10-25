import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/lightning_controller.dart';

class LightningView extends StatelessWidget {
  late double mWidth;
  late double mHeight;

  final LightningController controller = Get.put(LightningController());

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<LightningController>(
      init: controller,
      dispose: (_) {
        controller.onClose();
      },
      builder: (context) {
        return Scaffold(
          body: Container(
            child: VideoPlayer(controller.videocontroller!),
          ),
        );
      },
    );
  }
}

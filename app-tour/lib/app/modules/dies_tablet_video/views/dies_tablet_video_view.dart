import 'package:app/app/modules/dies_tablet_video/controllers/dies_tablet_video_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DiesTabletVideoView extends StatelessWidget {
  late double mWidth;
  late double mHeight;

  final DiesTabletVideoController controller =
      Get.put(DiesTabletVideoController());

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<DiesTabletVideoController>(
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

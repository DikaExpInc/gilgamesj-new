import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_talking_video_controller.dart';

class PreGameTalkingVideoView extends GetView<PreGameTalkingVideoController> {
  const PreGameTalkingVideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGameTalkingVideoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGameTalkingVideoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

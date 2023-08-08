import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonus_camera_controller.dart';

class BonusCameraView extends GetView<BonusCameraController> {
  const BonusCameraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonusCameraView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BonusCameraView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

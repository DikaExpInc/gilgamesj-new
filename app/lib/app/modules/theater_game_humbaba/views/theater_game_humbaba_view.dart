import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_humbaba_controller.dart';

class TheaterGameHumbabaView extends GetView<TheaterGameHumbabaController> {
  const TheaterGameHumbabaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameHumbabaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameHumbabaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

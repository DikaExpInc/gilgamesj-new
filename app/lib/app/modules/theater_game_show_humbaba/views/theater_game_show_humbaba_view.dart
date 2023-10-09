import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_show_humbaba_controller.dart';

class TheaterGameShowHumbabaView
    extends GetView<TheaterGameShowHumbabaController> {
  const TheaterGameShowHumbabaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameShowHumbabaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameShowHumbabaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

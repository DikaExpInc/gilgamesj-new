import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_reviving_controller.dart';

class TheaterGameRevivingView extends GetView<TheaterGameRevivingController> {
  const TheaterGameRevivingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameRevivingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameRevivingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

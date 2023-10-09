import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_tablet_dies_controller.dart';

class TheaterGameTabletDiesView
    extends GetView<TheaterGameTabletDiesController> {
  const TheaterGameTabletDiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TheaterGameTabletDiesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TheaterGameTabletDiesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

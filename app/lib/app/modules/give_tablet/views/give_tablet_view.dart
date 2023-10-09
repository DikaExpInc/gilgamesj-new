import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/give_tablet_controller.dart';

class GiveTabletView extends GetView<GiveTabletController> {
  const GiveTabletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GiveTabletView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GiveTabletView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

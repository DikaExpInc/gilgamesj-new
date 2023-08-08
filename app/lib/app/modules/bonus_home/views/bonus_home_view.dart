import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonus_home_controller.dart';

class BonusHomeView extends GetView<BonusHomeController> {
  const BonusHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BonusHomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BonusHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

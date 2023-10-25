import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bring_tablet_back_controller.dart';

class BringTabletBackView extends GetView<BringTabletBackController> {
  const BringTabletBackView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BringTabletBackView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BringTabletBackView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

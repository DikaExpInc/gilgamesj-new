import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rules_controller.dart';

class RulesView extends GetView<RulesController> {
  const RulesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RulesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RulesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

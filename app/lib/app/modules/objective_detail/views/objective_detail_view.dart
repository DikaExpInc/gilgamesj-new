import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/objective_detail_controller.dart';

class ObjectiveDetailView extends GetView<ObjectiveDetailController> {
  const ObjectiveDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectiveDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ObjectiveDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

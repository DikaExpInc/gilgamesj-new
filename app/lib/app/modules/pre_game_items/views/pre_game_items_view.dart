import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_items_controller.dart';

class PreGameItemsView extends GetView<PreGameItemsController> {
  const PreGameItemsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreGameItemsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreGameItemsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

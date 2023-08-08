import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_detail_controller.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  const ChatDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChatDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

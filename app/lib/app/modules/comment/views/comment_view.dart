import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comment_controller.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:app/app/modules/comment/controllers/comment_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CommentView extends GetView<CommentController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0), BlendMode.srcOver),
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                child: Center(
                  child: Text("Data history masih belum ada"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

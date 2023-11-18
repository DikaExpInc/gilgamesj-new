import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ticket_blank_controller.dart';

class TicketBlankView extends GetView<TicketBlankController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<TicketBlankController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: mWidth,
          height: mHeight,
        ),
      );
    });
  }
}

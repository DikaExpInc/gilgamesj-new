import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/error_controller.dart';

class ErrorView extends GetView<ErrorController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: mWidth,
      height: mHeight,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/gif/error-tablet.gif"),
          fit: BoxFit.cover,
        ),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     SizedBox(),
      //     Column(
      //       children: [
      //         Text(
      //           "Tablet error, leg onder je stoel.",
      //           style: TextStyle(
      //             fontSize: 64,
      //             color: Colors.white,
      //             fontWeight: FontWeight.w700,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //       ],
      //     ),
      //     Center(),
      //   ],
      // ),
    ));
  }
}

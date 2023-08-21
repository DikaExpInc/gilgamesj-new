import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/go_theater_controller.dart';

class GoTheaterView extends GetView<GoTheaterController> {
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "GAME IS OVER",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          Text(
            "Go to the Theatre",
            style: TextStyle(
              fontSize: 64,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Center(
          //   child: Column(
          //     children: [
          //       InkWell(
          //         onTap: () => {},
          //         child: Container(
          //           width: mWidth / 4,
          //           padding: EdgeInsets.symmetric(
          //               vertical: 20.0,
          //               horizontal:
          //                   MediaQuery.of(context).size.width > 600 ? 50 : 20),
          //           decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: AssetImage("assets/images/bg_btn.png"),
          //               fit: BoxFit.fill,
          //             ),
          //           ),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 "DOORGAN",
          //                 style: TextStyle(
          //                   fontSize: MediaQuery.of(context).size.width > 600
          //                       ? 16
          //                       : 12,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 80,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/blank/controllers/blank_controller.dart';

class BlankView extends GetView<BlankController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamTeam(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                Map<String, dynamic> user = snapshot.data!.data()!;
                return Container(
                  width: mWidth,
                  height: mHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          user['group'] == "1"
                              ? Colors.blueAccent.withOpacity(0.5)
                              : (user['group'] == "2"
                                  ? Colors.greenAccent.withOpacity(0.5)
                                  : (user['group'] == "3"
                                      ? Colors.yellowAccent.withOpacity(0.5)
                                      : Colors.redAccent.withOpacity(0.5))),
                          BlendMode.srcOver),
                      image: AssetImage("assets/images/background2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${user['name']}",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Group",
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${user['group']}",
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return Center(child: Text("Error"));
            }
          }),
    );
  }
}

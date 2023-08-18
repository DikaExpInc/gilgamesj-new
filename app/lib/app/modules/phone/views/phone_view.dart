import 'package:app/app/modules/phone/controllers/phone_controller.dart';
import 'package:app/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class PhoneView extends GetView<PhoneController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.myTabs.map((GetView tab) {
                      return tab;
                    }).toList(),
                  ),
                ),
              ),
              Positioned(
                top: 85,
                left: MediaQuery.of(context).size.width > 600 ? 140 : 60,
                right: MediaQuery.of(context).size.width > 600 ? 140 : 60,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: TabBar(
                    controller: controller.tabController,
                    // give the indicator a decoration (color and border radius)
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: AppColor.primary,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      // first tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Telefoon',
                      ),
                      // second tab [you can add an icon using the icon property]
                      Tab(
                        text: 'Contacten',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

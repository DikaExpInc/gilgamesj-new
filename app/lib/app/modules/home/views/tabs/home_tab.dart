import 'package:app/app/controllers/page_all_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/views/tabs/widgets/menu_widget.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeTab extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;

  final PageAllController pageAllController = Get.find<PageAllController>();
  final PageController hPagerController;

  HomeTab({required this.hPagerController});

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: mHeight / 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => hPagerController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_objective.png"),
              ),
              InkWell(
                onTap: () => hPagerController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_task.png"),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: mHeight / 25, left: mWidth / 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Obx(() {
                    String countdown = pageAllController.countdown.value;
                    return Text(
                      "${countdown}",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                  Text(
                    "Vrijdag, 31 maart",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  mWidth / (MediaQuery.of(context).size.width > 600 ? 10 : 15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_sosmed.png',
                    title: "Onstaram",
                    press: () {
                      Get.toNamed(Routes.SOCIAL_MEDIA);
                    },
                  ),
                  MenuWidget(
                    status: 1 > 0 || 1 > 0,
                    icon: 'assets/images/ic_gallery.png',
                    title: "Gallerij",
                    press: () {
                      Get.toNamed(Routes.GALLERY);
                    },
                  ),
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_map.png',
                    title: "Kaart",
                    press: () => Get.toNamed(Routes.MAP),
                  ),
                  SizedBox(
                    width: 90,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_chat.png',
                    title: "Chat",
                    press: () => Get.toNamed(
                      Routes.CHAT,
                    ),
                  ),
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_camera.png',
                    title: "Camera",
                    press: () {
                      Get.toNamed(Routes.CAMERA);
                    },
                  ),
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_phone.png',
                    title: "Telefoon",
                    press: () {
                      Get.toNamed(Routes.PHONE);
                    },
                  ),
                  MenuWidget(
                    status: 1 > 0,
                    icon: 'assets/images/ic_browser.png',
                    title: "Internet",
                    press: () {
                      Get.toNamed(Routes.BROWSER);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

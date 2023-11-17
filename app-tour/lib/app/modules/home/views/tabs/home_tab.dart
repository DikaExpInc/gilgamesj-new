import 'package:gilgamesj_tour/app/controllers/page_all_controller.dart';
import 'package:gilgamesj_tour/app/modules/home/controllers/home_controller.dart';
import 'package:gilgamesj_tour/app/modules/home/views/tabs/widgets/menu_widget.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
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

    return GetBuilder<HomeController>(builder: (controller) {
      if (controller.pageAllController.tasks?.statusCode == 200) {
        RxInt count_sosmed = 0.obs;
        RxInt count_gallery_photo = 0.obs;
        RxInt count_gallery_video = 0.obs;
        RxInt count_maps = 0.obs;
        RxInt count_chat = 0.obs;
        RxInt count_camera = 0.obs;
        RxInt count_phone = 0.obs;
        RxInt count_browser = 0.obs;

        count_sosmed.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "social media")
            .length;
        count_gallery_photo.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "gallery photo")
            .length;
        count_gallery_video.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "gallery video")
            .length;
        count_maps.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "maps")
            .length;
        count_chat.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "chat")
            .length;
        count_camera.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "camera")
            .length;
        count_phone.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "phone")
            .length;
        count_browser.value = controller.pageAllController.tasks!.items!
            .where((task) => task.type == "browser")
            .length;
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
                  horizontal: mWidth /
                      (MediaQuery.of(context).size.width > 600 ? 10 : 15)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuWidget(
                        status: count_sosmed > 0,
                        icon: 'assets/images/ic_sosmed.png',
                        title: "Onstaram",
                        press: () {
                          Get.toNamed(Routes.SOCIAL_MEDIA);
                        },
                      ),
                      MenuWidget(
                        status:
                            count_gallery_photo > 0 || count_gallery_video > 0,
                        icon: 'assets/images/ic_gallery.png',
                        title: "Gallerij",
                        press: () {
                          Get.toNamed(Routes.GALLERY);
                        },
                      ),
                      MenuWidget(
                        status: count_maps > 0,
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
                        status: count_chat > 0,
                        icon: 'assets/images/ic_chat.png',
                        title: "Chat",
                        press: () => Get.toNamed(
                          Routes.CHAT,
                        ),
                      ),
                      MenuWidget(
                        status: count_camera > 0,
                        icon: 'assets/images/ic_camera.png',
                        title: "Camera",
                        press: () {
                          Get.toNamed(Routes.CAMERA);
                        },
                      ),
                      MenuWidget(
                        status: count_phone > 0,
                        icon: 'assets/images/ic_phone.png',
                        title: "Telefoon",
                        press: () {
                          Get.toNamed(Routes.PHONE);
                        },
                      ),
                      MenuWidget(
                        status: count_browser > 0,
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
      } else {
        return Container(
          child: Text("Empty"),
        );
      }
    });
  }
}

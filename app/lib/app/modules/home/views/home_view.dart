import 'package:app/app/controllers/page_all_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/views/tabs/home_tab.dart';
import 'package:app/app/modules/home/views/tabs/objective_tab.dart';
import 'package:app/app/modules/home/views/tabs/task_tab.dart';
import 'package:app/app/widgets/pulsating_opacity_overlay.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  PageController hPagerController =
      PageController(keepPage: true, initialPage: 1);

  PageController vPagerController = PageController(keepPage: true);
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    Get.put(PageAllController());
    final PageAllController pageAllController = Get.find<PageAllController>();

    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Menghentikan audio
          await controller.audioPlayer?.stop();
          await controller.audioCache.fixedPlayer?.stop();
          return true; // Melanjutkan tindakan bawaan tombol kembali
        },
        child: Container(
          width: mWidth,
          height: mHeight,
          // color: colors[0],
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.srcOver),
              image: CachedNetworkImageProvider(
                controller.box.read("background_url"),
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              PageView(controller: hPagerController, children: [
                ObjectiveTab(hPagerController: hPagerController),
                HomeTab(hPagerController: hPagerController),
                TaskTab(hPagerController: hPagerController),
              ]),
              Obx(
                () => pageAllController.countdownInMinutes < 1
                    ? IgnorePointer(
                        ignoring: true, child: PulsatingOpacityOverlay())
                    : IgnorePointer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

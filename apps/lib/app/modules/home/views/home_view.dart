import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/controllers/page_all_controller.dart';
import 'package:gilgamesj/app/modules/home/controllers/home_controller.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/home_tab.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/objective_tab.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/task_tab.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:gilgamesj/app/widgets/pulsating_opacity_overlay.dart';
import 'package:pattern_lock/pattern_lock.dart';

class HomeView extends GetView<HomeController> {
  PageController hPagerController =
      PageController(keepPage: true, initialPage: 1);
  final PageAllController pageAllController = Get.find<PageAllController>();
  PageController vPagerController = PageController(keepPage: true);
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
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

import 'package:gilgamesj_tour/app/modules/browser/views/widgets/news_widget.dart';
import 'package:gilgamesj_tour/app/utils/app_color.dart';
import 'package:gilgamesj_tour/app/widgets/navbar_browser.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/api.dart';
import '../controllers/browser_controller.dart';

// ignore: must_be_immutable
class BrowserView extends GetView<BrowserController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<BrowserController>(builder: (controller) {
      if (controller.pageAllController.browsers?.statusCode == 200) {
        Set taskDetailIds = controller.pageAllController.tasks!.items!
            .map((task) => task.detailId)
            .toSet();

        // Membuat list boolean untuk menyimpan hasil pengecekan
        List<bool> hasDetailIds = controller.pageAllController.browsers!.items!
            .map((browserSnapshot) =>
                taskDetailIds.contains(browserSnapshot.sId))
            .toList();

        List taskIds =
            controller.pageAllController.browsers!.items!.map((browser) {
          var task;
          try {
            task = controller.pageAllController.tasks!.items!
                .firstWhere((task) => task.detailId == browser.sId);
          } catch (_) {
            task = null;
          }
          return task != null ? task.sId : '';
        }).toList();
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64.0,
                          vertical: 16.0,
                        ),
                        child: Column(
                          children: [
                            NavbarWidget(mWidth: mWidth),
                            Padding(
                              padding: const EdgeInsets.only(top: 54),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24.0),
                                    child: Container(
                                      width: 4, // Lebar pembatas
                                      height: 30,
                                      color: AppColor.primary, // Warna pembatas
                                    ),
                                  ),
                                  Text(
                                    "Nieuws",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller
                                    .pageAllController.browsers!.items!.length >
                                0
                            ? ListView.separated(
                                itemCount: controller
                                    .pageAllController.browsers!.items!.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  var browserData = controller.pageAllController
                                      .browsers!.items![index];
                                  return NewsWidget(
                                    mWidth: mWidth,
                                    title: '${browserData.title}',
                                    description: '${browserData.description}',
                                    mediaUrl:
                                        '${SharedApi().imageUrl}${browserData.image}',
                                    isActive: hasDetailIds[index],
                                    taskId: taskIds[index],
                                  );
                                },
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    "There is no news data yet",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else
        return Container();
    });
  }
}

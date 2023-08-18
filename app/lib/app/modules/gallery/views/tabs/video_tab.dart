import 'package:app/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../widgets/video_list.dart';

// ignore: must_be_immutable
class VideoTab extends GetView<GalleryController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<GalleryController>(builder: (controller) {
      if (controller.pageAllController.galleryVideos?.statusCode == 200) {
        Set taskDetailIds = controller.pageAllController.tasks!.items!
            .map((task) => task.detailId)
            .toSet();

        // Membuat list boolean untuk menyimpan hasil pengecekan
        List<bool> hasDetailIds = controller
            .pageAllController.galleryVideos!.items!
            .map((taskSnapshot) => taskDetailIds.contains(taskSnapshot.sId))
            .toList();
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 128,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64.0,
                          vertical: 16.0,
                        ),
                        child: controller.pageAllController.galleryVideos!
                                    .items!.length >
                                0
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VideoListWidget(
                                    date: "22 March 2023",
                                    listVideo: controller
                                        .pageAllController.galleryVideos!,
                                    listAllTask: controller
                                        .pageAllController.tasks!.items!,
                                    listIsActiveTask: hasDetailIds,
                                  ),
                                ],
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    "There is no video data yet",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

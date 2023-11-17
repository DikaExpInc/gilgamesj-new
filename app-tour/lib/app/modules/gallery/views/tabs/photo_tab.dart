import 'package:gilgamesj_tour/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../widgets/photo_list.dart';

// ignore: must_be_immutable
class PhotoTab extends GetView<GalleryController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<GalleryController>(builder: (controller) {
      if (controller.pageAllController.galleryPhotos?.statusCode == 200) {
        Set taskDetailIds = controller.pageAllController.tasks!.items!
            .map((task) => task.detailId)
            .toSet();

        // Membuat list boolean untuk menyimpan hasil pengecekan
        List<bool> hasDetailIds = controller
            .pageAllController.galleryPhotos!.items!
            .map((gallerySnapshot) =>
                taskDetailIds.contains(gallerySnapshot.sId))
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
                        child: controller.pageAllController.galleryPhotos!
                                    .items!.length >
                                0
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PhotoListWidget(
                                    date: "22 March 2023",
                                    listPhoto: controller
                                        .pageAllController.galleryPhotos!,
                                    listAllTask: controller
                                        .pageAllController.tasks!.items!,
                                    listIsActiveTask: hasDetailIds,
                                  ),
                                ],
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    "There is no photo data yet",
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

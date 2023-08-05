import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:gilgamesj/app/modules/gallery/views/widgets/video_list.dart';

class VideoTab extends GetView<GalleryController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // VideoListWidget(
                        //     date: "23 March 2023",
                        //     images: ["bg_1.png", "bg_2.png"],
                        //     videos: ["", "", "", "", ""]),
                        // SizedBox(
                        //   height: 24,
                        // ),
                        // VideoListWidget(date: "22 March 2023", images: [
                        //   "bg_1.png",
                        //   "bg_2.png",
                        //   "bg_2.png",
                        //   "bg_2.png",
                        //   "bg_2.png",
                        // ], videos: [
                        //   "",
                        //   "",
                        //   "",
                        //   "",
                        //   ""
                        // ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

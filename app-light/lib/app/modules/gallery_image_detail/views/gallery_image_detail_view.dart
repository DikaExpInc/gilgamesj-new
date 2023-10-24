import 'package:app/app/modules/gallery_image_detail/controllers/gallery_image_detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class GalleryImageDetailView extends GetView<GalleryImageDetailController> {
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
                    height: 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mWidth > 600 ? 64.0 : 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => {Get.back()},
                              child: Icon(
                                Icons.chevron_left_sharp,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${controller.arguments["date"]}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${controller.arguments["name"]}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: mWidth,
                    height: mHeight / 1.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "${controller.arguments["image"]}",
                        ),
                        fit: BoxFit.cover,
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
  }
}

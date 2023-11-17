import 'package:gilgamesj_tour/app/modules/news_detail/controllers/news_detail_controller.dart';
import 'package:gilgamesj_tour/app/widgets/navbar_browser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class NewsDetailView extends GetView<NewsDetailController> {
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
                  image: AssetImage("assets/images/background3.png"),
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
                    child: NavbarWidget(mWidth: mWidth),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: mWidth,
                          height: mHeight / 4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                controller.newsData['mediaUrl'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 64.0,
                            vertical: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                child: Text(
                                  "${controller.newsData['title']}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              Text(
                                "${controller.newsData['description']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
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

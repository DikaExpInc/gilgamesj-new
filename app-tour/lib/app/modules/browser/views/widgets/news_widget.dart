// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/modules/browser/controllers/browser_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NewsWidget extends GetView<BrowserController> {
  late double mWidth;
  final String title;
  final String description;
  final String mediaUrl;
  final String taskId;
  final bool isActive;

  NewsWidget({
    Key? key,
    required this.mWidth,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.taskId,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        // if (isActive) {controller.openTask(taskId)},
        Get.toNamed(Routes.NEWS_DETAIL, arguments: {
          "title": title,
          "description": description,
          "mediaUrl": mediaUrl,
        })
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 64.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 150, // Lebar kontainer
                      height: 90, // Tinggi kontainer
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "${mediaUrl}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      width: mWidth / 2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${title}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            '${description}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            softWrap: true,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

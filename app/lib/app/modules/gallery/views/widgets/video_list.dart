import 'dart:ffi';

import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoListWidget extends StatelessWidget {
  final String date;
  final List<String> images;
  final List<String> videos;

  const VideoListWidget({
    Key? key,
    required this.date,
    required this.images,
    required this.videos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${date}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> arguments = {
                  'video': videos[index],
                  'image': images[index],
                  'date': date,
                };
                return InkWell(
                  onTap: () => {
                    Get.toNamed(Routes.GALLERY_VIDEO_DETAIL,
                        arguments: arguments)
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/${images[index]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_filled,
                          size: 48,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

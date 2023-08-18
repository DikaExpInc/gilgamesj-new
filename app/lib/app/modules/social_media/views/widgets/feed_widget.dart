import 'package:app/app/modules/social_media/controllers/social_media_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/utils/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedWidget extends GetView<SocialMediaController> {
  final String id;
  final String profileUrl;
  final String date;
  final String mediaUrl;
  final int like;
  final String name;
  final String description;
  final String location;

  const FeedWidget({
    Key? key,
    required this.id,
    required this.profileUrl,
    required this.date,
    required this.mediaUrl,
    required this.like,
    required this.name,
    required this.description,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late double mWidth;
    late double mHeight;
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 600 ? 64.0 : 30,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      '${SharedApi().imageUrl}${profileUrl}',
                    ),
                    radius: 40,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 20 : 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${location}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 14 : 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                '${DateFormat('dd MMMM yyyy', 'id_ID').format(DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z", 'en_US').parse(date))}',
                style: TextStyle(
                  color: AppColor.primary,
                ),
              )
            ],
          ),
        ),
        Container(
          width: mWidth,
          height: mHeight / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                "${SharedApi().imageUrl}${mediaUrl}",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 600 ? 64.0 : 30,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => controller.like(id),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal:
                              MediaQuery.of(context).size.width > 600 ? 50 : 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg_btn.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${like}",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width > 600
                                  ? 16
                                  : 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () => {
                          // if (isActive) {controller.openTask(taskId)},
                          Get.toNamed(Routes.COMMENT, arguments: {
                            "id": id,
                            "profile": "${SharedApi().imageUrl}${profileUrl}",
                            "name": name,
                            "description": description,
                          })
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal:
                                  MediaQuery.of(context).size.width > 600
                                      ? 50
                                      : 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/bg_btn.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Comment",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                          ? 16
                                          : 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // isActive
                      //     ? Positioned(
                      //         right:
                      //             10, // Atur posisi horizontal ikon tanda seru
                      //         child: Icon(
                      //           Icons
                      //               .error_outline, // Ganti dengan ikon tanda seru yang sesuai
                      //           size: 36,
                      //           color: Colors.red,
                      //         ),
                      //       )
                      //     :
                      Container(),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  '${description}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.width > 600 ? 16 : 12),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

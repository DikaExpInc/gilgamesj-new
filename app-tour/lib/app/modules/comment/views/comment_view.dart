import 'package:gilgamesj_tour/app/modules/comment/controllers/comment_controller.dart';
import 'package:gilgamesj_tour/app/modules/comment/views/widget/comment_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/api.dart';

// ignore: must_be_immutable
class CommentView extends GetView<CommentController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<CommentController>(builder: (controller) {
      if (controller.pageAllController.socialMediaComments?.statusCode == 200) {
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
                  child: controller.pageAllController.socialMediaComments!
                              .items!.length >
                          0
                      ? Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mWidth > 600 ? 64.0 : 30,
                                vertical: 16.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          '${controller.sosmedData['profile']}',
                                        ),
                                        radius: 40,
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.sosmedData['name']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Container(
                                            width: mWidth / 1.7,
                                            child: Text(
                                              '${controller.sosmedData['description']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              softWrap: true,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  ListView.separated(
                                    itemCount: controller.pageAllController
                                        .socialMediaComments!.items!.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      var commentData = controller
                                          .pageAllController
                                          .socialMediaComments!
                                          .items![index];
                                      return CommentWidget(
                                        profileUrl:
                                            '${SharedApi().imageUrl}${commentData.profile}',
                                        name: '${commentData.name}',
                                        comment: '${commentData.comment}',
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mWidth > 600 ? 64.0 : 30,
                                vertical: 16.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          '${controller.sosmedData['profile']}',
                                        ),
                                        radius: 40,
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.sosmedData['name']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Container(
                                            width: mWidth / 1.7,
                                            child: Text(
                                              '${controller.sosmedData['description']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              softWrap: true,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "No Comment",
                                    style: TextStyle(color: Colors.white),
                                  )
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
      } else
        return Container();
    });
  }
}

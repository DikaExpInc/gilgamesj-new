import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/comment/controllers/comment_controller.dart';
import 'package:gilgamesj/app/modules/comment/views/widget/comment_widget.dart';
import 'package:gilgamesj/app/modules/social_media/views/widgets/feed_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:pattern_lock/pattern_lock.dart';

class CommentView extends GetView<CommentController> {
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
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamComment(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            listComment = snapshot.data!.docs;
                        List<String> documentIds =
                            listComment.map((snapshot) => snapshot.id).toList();

                        return listComment.length > 0
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                '${controller.stageData['profileUrl']}',
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
                                                  '${controller.stageData['name']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Container(
                                                  width: mWidth / 1.7,
                                                  child: Text(
                                                    '${controller.stageData['description']}',
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
                                            itemCount: listComment.length,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 16),
                                            itemBuilder: (context, index) {
                                              var commentData =
                                                  listComment[index].data();
                                              print(commentData);
                                              return CommentWidget(
                                                profileUrl:
                                                    commentData['profileUrl'],
                                                name: commentData['name'],
                                                comment: commentData['comment'],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                child: Center(
                                  child: Text("Data history masih belum ada"),
                                ),
                              );
                      default:
                        return SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

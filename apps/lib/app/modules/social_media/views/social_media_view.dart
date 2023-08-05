import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/social_media/controllers/social_media_controller.dart';
import 'package:gilgamesj/app/modules/social_media/views/widgets/feed_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:pattern_lock/pattern_lock.dart';

class SocialMediaView extends GetView<SocialMediaController> {
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
              child: Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: controller.streamSocialMedia(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                listSosmed = snapshot.data!.docs;
                            List<String> documentIds = listSosmed
                                .map((snapshot) => snapshot.id)
                                .toList();

                            Set taskDetailIds = controller.tasks
                                .map((task) => task["detail_id"])
                                .toSet();

                            // Membuat list boolean untuk menyimpan hasil pengecekan
                            List<bool> hasDetailIds = listSosmed
                                .map((taskSnapshot) =>
                                    taskDetailIds.contains(taskSnapshot.id))
                                .toList();

                            List taskIds = documentIds.map((id) {
                              var task;
                              try {
                                task = controller.tasks.firstWhere(
                                    (task) => task['detail_id'] == id);
                              } catch (_) {
                                task = null;
                              }
                              return task != null ? task['id'] : '';
                            }).toList();

                            return listSosmed.length > 0
                                ? ListView.separated(
                                    itemCount: listSosmed.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      var sosmedData = listSosmed[index].data();
                                      return FeedWidget(
                                        id: documentIds[index],
                                        profileUrl: sosmedData['profileUrl'],
                                        date: sosmedData['date'],
                                        mediaUrl: sosmedData['mediaUrl'],
                                        like: sosmedData['like'],
                                        name: sosmedData['name'],
                                        description: sosmedData['description'],
                                        location: sosmedData['location'],
                                        isActive: hasDetailIds[index],
                                        taskId: taskIds[index],
                                      );
                                    })
                                : Container(
                                    child: Center(
                                      child: Text(
                                          "There is no social media data yet"),
                                    ),
                                  );
                          } else {
                            return Container(
                              child: Center(
                                child: Text(
                                  "There is no social media data yet",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        default:
                          return SizedBox();
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

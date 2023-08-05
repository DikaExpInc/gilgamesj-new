import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/browser/controllers/browser_controller.dart';
import 'package:gilgamesj/app/modules/browser/views/widgets/news_widget.dart';
import 'package:gilgamesj/app/modules/social_media/views/widgets/feed_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:gilgamesj/app/widgets/navbar_browser.dart';
import 'package:pattern_lock/pattern_lock.dart';

class BrowserView extends GetView<BrowserController> {
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
                    child: Column(
                      children: [
                        NavbarWidget(mWidth: mWidth),
                        Padding(
                          padding: const EdgeInsets.only(top: 54),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Container(
                                  width: 4, // Lebar pembatas
                                  height: 30,
                                  color: AppColor.primary, // Warna pembatas
                                ),
                              ),
                              Text(
                                "Nieuws",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamBrowser(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> listBrowser =
                                    snapshot.data!.docs;
                                List<String> documentIds = listBrowser
                                    .map((snapshot) => snapshot.id)
                                    .toList();

                                Set taskDetailIds = controller.tasks
                                    .map((task) => task["detail_id"])
                                    .toSet();

                                // Membuat list boolean untuk menyimpan hasil pengecekan
                                List<bool> hasDetailIds = listBrowser
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

                                return listBrowser.length > 0
                                    ? ListView.separated(
                                        itemCount: listBrowser.length,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 16),
                                        itemBuilder: (context, index) {
                                          var browserData =
                                              listBrowser[index].data();
                                          return NewsWidget(
                                            mWidth: mWidth,
                                            title: browserData['title'],
                                            description:
                                                browserData['description'],
                                            mediaUrl:
                                                browserData['downloadUrl'],
                                            isActive: hasDetailIds[index],
                                            taskId: taskIds[index],
                                          );
                                        })
                                    : Container(
                                        child: Center(
                                          child: Text(
                                            "There is no news data yet",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      "There is no news data yet",
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
                  SizedBox(
                    height: 32,
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

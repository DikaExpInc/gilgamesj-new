import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:gilgamesj/app/modules/gallery/views/widgets/photo_list.dart';

class PhotoTab extends GetView<GalleryController> {
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
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            controller.streamGalleryPhoto().asBroadcastStream(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> listPhoto =
                                    snapshot.data!.docs;

                                Set taskDetailIds = controller.tasks
                                    .map((task) => task["detail_id"])
                                    .toSet();

                                // Membuat list boolean untuk menyimpan hasil pengecekan
                                List<bool> hasDetailIds = listPhoto
                                    .map((taskSnapshot) =>
                                        taskDetailIds.contains(taskSnapshot.id))
                                    .toList();

                                return listPhoto.length > 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PhotoListWidget(
                                            date: "22 March 2023",
                                            listPhoto: listPhoto,
                                            listAllTask: controller.tasks,
                                            listIsActiveTask: hasDetailIds,
                                          ),
                                        ],
                                      )
                                    : Container(
                                        child: Center(
                                          child: Text("Data is empty"),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

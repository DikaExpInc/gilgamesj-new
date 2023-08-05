import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/home/controllers/home_controller.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';

class ObjectiveTab extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;

  final PageController hPagerController;

  ObjectiveTab({required this.hPagerController});

  Orientation getScreenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = getScreenOrientation(context);
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: mHeight / 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => hPagerController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_back.png"),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: mHeight / 25, left: mWidth / 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kleitabletten",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 3.0,
                      width: 80.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamObjective().asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                List<QueryDocumentSnapshot<Map<String, dynamic>>>
                    listObjective = snapshot.data!.docs;
                List<String> objectiveIds =
                    listObjective.map((snapshot) => snapshot.id).toList();

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamObjectiveDone().asBroadcastStream(),
                  builder: (contextDone, snapshotDone) {
                    switch (snapshotDone.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            listObjectiveDone = snapshotDone.data!.docs;
                        List<String> objectiveDoneIds = listObjectiveDone
                            .map((snapshot) => snapshot.id)
                            .toList();

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: mWidth / 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${listObjectiveDone.length} van ${listObjective.length} kleitabletten",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mWidth / 10,
                                  vertical: mHeight / 15),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 50.0,
                                  crossAxisSpacing: 50.0,
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: listObjective.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Map<String, dynamic> arguments = {};
                                  return InkWell(
                                    onTap: () => {
                                      if (objectiveDoneIds
                                          .contains(objectiveIds[index]))
                                        {
                                          Get.toNamed(Routes.OBJECTIVE_DETAIL,
                                              arguments: arguments)
                                        }
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              colorFilter:
                                                  objectiveDoneIds.contains(
                                                          objectiveIds[index])
                                                      ? ColorFilter.mode(
                                                          Colors.transparent,
                                                          BlendMode.dst)
                                                      : ColorFilter.mode(
                                                          Colors.grey,
                                                          BlendMode.saturation),
                                              image: CachedNetworkImageProvider(
                                                listObjective[index]
                                                    ["imageUrl"],
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      default:
                        return SizedBox();
                    }
                  },
                );

              default:
                return SizedBox();
            }
          },
        ),
      ],
    );
  }
}

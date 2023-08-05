import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/controllers/page_all_controller.dart';
import 'package:gilgamesj/app/modules/home/controllers/home_controller.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/widgets/menu_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';
import 'package:intl/intl.dart';
import 'package:pattern_lock/pattern_lock.dart';

class HomeTab extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;

  final PageAllController pageAllController = Get.find<PageAllController>();
  final PageController hPagerController;

  HomeTab({required this.hPagerController});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: mHeight / 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => hPagerController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_objective.png"),
              ),
              InkWell(
                onTap: () => hPagerController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_task.png"),
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
                children: [
                  Obx(() {
                    String countdown = pageAllController.countdown.value;
                    return Text(
                      "${countdown}",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                  Text(
                    "Vrijdag, 31 maart",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  mWidth / (MediaQuery.of(context).size.width > 600 ? 10 : 15)),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamTask().asBroadcastStream(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> listTask =
                      snapshot.data!.docs;

                  RxInt completedTasks_sosmed = 0.obs;
                  RxInt completedTasks_gallery_photo = 0.obs;
                  RxInt completedTasks_gallery_video = 0.obs;
                  RxInt completedTasks_maps = 0.obs;
                  RxInt completedTasks_chat = 0.obs;
                  RxInt completedTasks_camera = 0.obs;
                  RxInt completedTasks_phone = 0.obs;
                  RxInt completedTasks_browser = 0.obs;

                  List<dynamic> icons = listTask.map((taskSnapshot) {
                    var taskData = taskSnapshot.data() as Map<String, dynamic>;
                    var iconValue = taskData["type"];
                    return iconValue;
                  }).toList();

                  List<Future<bool>> taskExistsFutures =
                      listTask.map((taskSnapshot) {
                    return controller.checkTaskExists(taskSnapshot.id);
                  }).toList();

                  Future.wait(taskExistsFutures).then((List<dynamic> results) {
                    for (int i = 0; i < listTask.length; i++) {
                      var taskData = listTask[i].data();
                      var iconValue = taskData["type"];
                      bool taskExists =
                          results[i] ?? false; // Gunakan hasil dari Future

                      if (iconValue == "social media") {
                        if (taskExists) {
                          completedTasks_sosmed.value++;
                        }
                      } else if (iconValue == "gallery photo") {
                        if (taskExists) {
                          completedTasks_gallery_photo.value++;
                        }
                      } else if (iconValue == "gallery video") {
                        if (taskExists) {
                          completedTasks_gallery_video.value++;
                        }
                      } else if (iconValue == "maps") {
                        if (taskExists) {
                          completedTasks_maps.value++;
                        }
                      } else if (iconValue == "chat") {
                        if (taskExists) {
                          completedTasks_chat.value++;
                        }
                      } else if (iconValue == "camera") {
                        if (taskExists) {
                          completedTasks_camera.value++;
                        }
                      } else if (iconValue == "phone") {
                        if (taskExists) {
                          completedTasks_phone.value++;
                        }
                      } else if (iconValue == "browser") {
                        if (taskExists) {
                          completedTasks_browser.value++;
                        }
                      }
                    }
                  });

                  RxInt count_sosmed = 0.obs;
                  RxInt count_gallery_photo = 0.obs;
                  RxInt count_gallery_video = 0.obs;
                  RxInt count_maps = 0.obs;
                  RxInt count_chat = 0.obs;
                  RxInt count_camera = 0.obs;
                  RxInt count_phone = 0.obs;
                  RxInt count_browser = 0.obs;

                  return Obx(() {
                    // Hitung nilai RxInt berdasarkan kondisi
                    count_sosmed.value =
                        icons.where((icon) => icon == "social media").length -
                            completedTasks_sosmed.value;
                    count_gallery_photo.value =
                        icons.where((icon) => icon == "gallery photo").length -
                            completedTasks_gallery_photo.value;
                    count_gallery_video.value =
                        icons.where((icon) => icon == "gallery video").length -
                            completedTasks_gallery_video.value;
                    count_maps.value =
                        icons.where((icon) => icon == "maps").length -
                            completedTasks_maps.value;
                    count_chat.value =
                        icons.where((icon) => icon == "chat").length -
                            completedTasks_chat.value;
                    count_camera.value =
                        icons.where((icon) => icon == "camera").length -
                            completedTasks_camera.value;
                    count_phone.value =
                        icons.where((icon) => icon == "phone").length -
                            completedTasks_phone.value;
                    count_browser.value =
                        icons.where((icon) => icon == "browser").length -
                            completedTasks_browser.value;

                    // Check data for chat
                    List<dynamic> filteredChats = listTask
                        .where((taskSnapshot) =>
                            taskSnapshot.data()["type"] == "chat")
                        .toList();

                    List docChatIds = filteredChats
                        .map((taskSnapshot) => taskSnapshot.id)
                        .toList();

                    // Check data for maps
                    List<dynamic> filteredMaps = listTask
                        .where((taskSnapshot) =>
                            taskSnapshot.data()["type"] == "maps")
                        .toList();

                    List docMapsIds = filteredMaps
                        .map((taskSnapshot) => taskSnapshot.id)
                        .toList();

                    return listTask.length > 0
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MenuWidget(
                                    status: count_sosmed > 0,
                                    icon: 'assets/images/ic_sosmed.png',
                                    title: "Onstaram",
                                    press: () {
                                      Get.toNamed(Routes.SOCIAL_MEDIA);
                                    },
                                  ),
                                  MenuWidget(
                                    status: count_gallery_video > 0 ||
                                        count_gallery_photo > 0,
                                    icon: 'assets/images/ic_gallery.png',
                                    title: "Gallerij",
                                    press: () {
                                      Get.toNamed(Routes.GALLERY);
                                    },
                                  ),
                                  MenuWidget(
                                    status: count_maps > 0,
                                    icon: 'assets/images/ic_map.png',
                                    title: "Kaart",
                                    press: () => Get.toNamed(Routes.MAP),
                                  ),
                                  SizedBox(
                                    width: 90,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MenuWidget(
                                    status: count_chat > 0,
                                    icon: 'assets/images/ic_chat.png',
                                    title: "Chat",
                                    press: () => Get.toNamed(
                                      Routes.CHAT,
                                    ),
                                  ),
                                  MenuWidget(
                                    status: count_camera > 0,
                                    icon: 'assets/images/ic_camera.png',
                                    title: "Camera",
                                    press: () {
                                      Get.toNamed(Routes.CAMERA);
                                    },
                                  ),
                                  MenuWidget(
                                    status: count_phone > 0,
                                    icon: 'assets/images/ic_phone.png',
                                    title: "Telefoon",
                                    press: () {
                                      Get.toNamed(Routes.PHONE);
                                    },
                                  ),
                                  MenuWidget(
                                    status: count_browser > 0,
                                    icon: 'assets/images/ic_browser.png',
                                    title: "Internet",
                                    press: () {
                                      Get.toNamed(Routes.BROWSER);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          )
                        : Container(
                            child: Center(
                              child: Text("Data history masih belum ada"),
                            ),
                          );
                  });
                default:
                  return SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}

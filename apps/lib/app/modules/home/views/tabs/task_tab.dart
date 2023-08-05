import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/home/controllers/home_controller.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/widgets/menu_widget.dart';
import 'package:gilgamesj/app/modules/home/views/tabs/widgets/task_widget.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';
import 'package:pattern_lock/pattern_lock.dart';

class TaskTab extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;

  final PageController hPagerController;

  TaskTab({required this.hPagerController});

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset("assets/images/ic_back2.png"),
              ),
              // InkWell(
              //   onTap: () => controller.logout(),
              //   child: Image.asset("assets/images/ic_logout.png"),
              // ),
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
                    "Opdrachten",
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
                      width: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(mWidth / 10),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamTask().asBroadcastStream(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            listTask = snapshot.data!.docs;
                        List<String> taskIds =
                            listTask.map((snapshot) => snapshot.id).toList();

                        return listTask.length > 0
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: listTask.length,
                                  itemBuilder: (context, index) {
                                    var taskData = listTask[index].data();
                                    String taskId = taskIds[index];
                                    return FutureBuilder<bool>(
                                      future:
                                          controller.checkTaskExists(taskId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          bool taskExists = snapshot.data!;
                                          return TaskWidget(
                                            status: taskExists,
                                            title: "${taskData['title']}",
                                            desc: "${taskData['description']}",
                                            press: () {
                                              CustomToast.successToast(
                                                'Task',
                                                'Task: ${taskData['title']}\nDescription: ${taskData['description']}',
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          // Menampilkan pesan error jika terjadi kesalahan
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // Menampilkan widget kosong jika tidak ada data yang ditemukan
                                          return Container();
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Text("Data task is still not there"),
                                ),
                              );
                      default:
                        return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

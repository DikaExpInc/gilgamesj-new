import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/chat/controllers/chat_controller.dart';
import 'package:gilgamesj/app/modules/chat/views/widgets/contact_widget.dart';
import 'package:gilgamesj/app/modules/social_media/views/widgets/feed_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';
import 'package:gilgamesj/app/style/app_color.dart';
import 'package:gilgamesj/app/widgets/toast/custom_toast.dart';
import 'package:pattern_lock/pattern_lock.dart';

class ChatView extends GetView<ChatController> {
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
                  image: AssetImage("assets/images/background4.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: mHeight / 15, left: mWidth / 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Chat",
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
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamChat().asBroadcastStream(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                List<
                                        QueryDocumentSnapshot<
                                            Map<String, dynamic>>> listChat =
                                    snapshot.data!.docs;
                                List<String> documentIds = listChat
                                    .map((snapshot) => snapshot.id)
                                    .toList();

                                Set taskDetailIds = controller.tasks
                                    .map((task) => task["detail_id"])
                                    .toSet();

                                // Membuat list boolean untuk menyimpan hasil pengecekan
                                List<bool> hasDetailIds = listChat
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

                                return listChat.length > 0
                                    ? ListView.separated(
                                        itemCount: listChat.length,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 16),
                                        itemBuilder: (context, index) {
                                          var chatData = listChat[index].data();
                                          return ContactWidget(
                                            profile: chatData['downloadUrl'],
                                            name: chatData['name'],
                                            last_chat: ".....",
                                            last_chat_time: "09:10 AM",
                                            total_chat_unread: 0,
                                            press: () => {
                                              if (hasDetailIds[index])
                                                {
                                                  controller.openTask(
                                                    taskIds[index],
                                                  )
                                                },
                                              Get.toNamed(
                                                Routes.CHAT_DETAIL,
                                                arguments: {
                                                  "chatId": documentIds[index],
                                                  "name": chatData['name'],
                                                  "profile":
                                                      chatData['downloadUrl'],
                                                },
                                              )
                                            },
                                          );
                                        },
                                      )
                                    : Container(
                                        child: Center(
                                          child:
                                              Text("There is no chat data yet"),
                                        ),
                                      );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text(
                                      "There is no chat data yet",
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

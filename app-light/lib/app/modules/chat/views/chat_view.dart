import 'package:app/app/modules/chat/views/widgets/contact_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/api.dart';
import '../controllers/chat_controller.dart';

// ignore: must_be_immutable
class ChatView extends GetView<ChatController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<ChatController>(builder: (controller) {
      if (controller.pageAllController.chats?.statusCode == 200) {
        Set taskDetailIds = controller.pageAllController.tasks!.items!
            .map((task) => task.detailId)
            .toSet();

        // Membuat list boolean untuk menyimpan hasil pengecekan
        List<bool> hasDetailIds = controller.pageAllController.chats!.items!
            .map((chatSnapshot) => taskDetailIds.contains(chatSnapshot.sId))
            .toList();

        // List taskIds = controller.pageAllController.socialMedias!.items!.map((sosmed) {
        //   var task;
        //   try {
        //     task = controller.pageAllController.tasks!.items!
        //         .firstWhere((task) => task.detailId == sosmed.sId);
        //   } catch (_) {
        //     task = null;
        //   }
        //   return task != null ? task.sId : '';
        // }).toList();

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
                        padding: EdgeInsets.only(
                            top: mHeight / 15, left: mWidth / 10),
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
                        child:
                            controller.pageAllController.chats!.items!.length >
                                    0
                                ? ListView.separated(
                                    itemCount: controller
                                        .pageAllController.chats!.items!.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      var chatData = controller
                                          .pageAllController
                                          .chats!
                                          .items![index];
                                      return ContactWidget(
                                        profile:
                                            '${SharedApi().imageUrl}${chatData.profile}',
                                        name: chatData.name.toString(),
                                        last_chat: ".....",
                                        last_chat_time: "09:10 AM",
                                        total_chat_unread: 0,
                                        press: () => {
                                          if (hasDetailIds[index]) {},
                                          Get.toNamed(
                                            Routes.CHAT_DETAIL,
                                            arguments: {
                                              "id": chatData.sId,
                                              "name": chatData.name,
                                              "profile":
                                                  '${SharedApi().imageUrl}${chatData.profile}',
                                            },
                                          )
                                        },
                                      );
                                    },
                                  )
                                : Container(
                                    child: Center(
                                      child: Text("There is no chat data yet"),
                                    ),
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

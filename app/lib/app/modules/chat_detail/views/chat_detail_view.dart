import 'package:app/app/modules/chat_detail/controllers/chat_detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChatDetailView extends GetView<ChatDetailController> {
  late double mWidth;
  late double mHeight;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  void _toggleBottomSheet() {
    Get.bottomSheet(Container(
      child: Center(
        child: Text(
          "No Chat Answer",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ));
    controller.toggleBottomSheetVisibility();
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Content of the screen
            Column(
              children: [
                Container(
                  width: mWidth,
                  height: mHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0), BlendMode.srcOver),
                      image: AssetImage("assets/images/background3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: mHeight / 15,
                          left: mWidth / 10,
                          right: mWidth / 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => {Get.back()},
                              child: Icon(
                                Icons.chevron_left_sharp,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${controller.chatData["name"]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  9, // Ukuran lebar lingkaran
                                              height:
                                                  9, // Ukuran tinggi lingkaran
                                              decoration: BoxDecoration(
                                                shape: BoxShape
                                                    .circle, // Mengatur bentuk menjadi lingkaran
                                                color: Colors
                                                    .green, // Warna latar belakang lingkaran
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Online',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        '${controller.chatData["profile"]}',
                                      ),
                                      radius: mWidth > 600 ? 40 : 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text("Data history masih belum ada"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleBottomSheet,
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}

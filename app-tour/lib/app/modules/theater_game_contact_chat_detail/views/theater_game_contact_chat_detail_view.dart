import 'package:gilgamesj_tour/app/modules/theater_game_chat_game/views/widgets/answer_widget.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_contact_chat_detail/views/widgets/chat_widget.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_contact_chat_detail_controller.dart';

class TheaterGameContactChatDetailView
    extends GetView<TheaterGameContactChatDetailController> {
  late double mWidth;
  late double mHeight;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    num getHeight = 2 > 2 ? 4 : 5;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: mWidth,
          height: mHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.srcOver),
              image: AssetImage("assets/images/background3-black.png"),
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
                        onTap: () {
                          Get.offAllNamed(Routes.THEATER_GAME_CONTACT_CHAT);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.asset(
                              'assets/icons/arrow-left-white.svg'),
                        )),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${controller.arguments['name']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 9, // Ukuran lebar lingkaran
                                      height: 9, // Ukuran tinggi lingkaran
                                      decoration: BoxDecoration(
                                        shape: BoxShape
                                            .circle, // Mengatur bentuk menjadi lingkaran
                                        color: controller.arguments['game'] ==
                                                'none'
                                            ? Colors.red
                                            : Colors
                                                .green, // Warna latar belakang lingkaran
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller.arguments['game'] == 'none'
                                          ? 'Offline'
                                          : 'Online',
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
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                '${controller.arguments['profile_url']}',
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
                child: Obx(
                  () => ListView.builder(
                    controller: _scrollController,
                    itemCount: controller.chatData.length,
                    itemBuilder: (context, index) {
                      final chat = controller.chatData[index];
                      final pesan = chat['pesan'] as String;
                      final position = chat['position'] as String;
                      // Tampilkan pesan chat
                      return ChatWidget(
                        chat: pesan,
                        type: position, // Atur sesuai kebutuhan
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: mWidth,
                height: mHeight / getHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  child: Obx(
                    () {
                      final currentChat = controller.chatData.isNotEmpty
                          ? controller.chatData.last
                          : null;

                      if (controller.isChoosingAnswer.value &&
                          currentChat != null) {
                        final jawaban = currentChat['jawaban']
                            as List<dynamic>?; // Ubah tipe ke List<dynamic>
                        if (jawaban != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < jawaban.length; i++)
                                i == 0
                                    ? AnswerWidget(
                                        title: jawaban[i]
                                            as String, // Cast setiap jawaban menjadi String
                                        position:
                                            true, // Sesuaikan dengan posisi yang sesuai
                                        press: () {
                                          controller.chooseAnswer(i);
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                      )
                                    : AnswerWidget(
                                        title: jawaban[i]
                                            as String, // Cast setiap jawaban menjadi String
                                        position:
                                            false, // Sesuaikan dengan posisi yang sesuai
                                        press: () {
                                          controller.chooseAnswer(i);
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                      ),
                            ],
                          );
                        }
                      }
                      return Column();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

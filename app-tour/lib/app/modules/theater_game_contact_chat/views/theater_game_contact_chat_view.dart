import 'package:app/app/modules/theater_game_contact_chat/views/widgets/contact_widget.dart';
import 'package:app/app/modules/theater_game_contact_chat/views/widgets/profile_abjad.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/theater_game_contact_chat_controller.dart';

class TheaterGameContactChatView
    extends GetView<TheaterGameContactChatController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                  height: 142,
                ),
                Center(
                  child: Text(
                    'Contacten',
                    style: const TextStyle(
                      fontFamily: 'Centrion',
                      fontSize: 46,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      // A
                      ProfileAbjad(title: 'A'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Annu',
                              "profile_url":
                                  'assets/images/ic_profile_annu.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Annu',
                        images: 'assets/images/ic_profile_annu.png',
                      ),
                      ProfileAbjad(title: 'E'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Enril',
                              "profile_url":
                                  'assets/images/ic_profile_enlil.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Enlil',
                        images: 'assets/images/ic_profile_enlil.png',
                      ),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Ereshkigal',
                              "profile_url":
                                  'assets/images/ic_profile_ereshkigal.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Ereshkigal',
                        images: 'assets/images/ic_profile_ereshkigal.png',
                      ),
                      ProfileAbjad(title: 'H'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Hemelstier',
                              "profile_url":
                                  'assets/images/ic_profile_hemelstier.png',
                              "game": 'hemelstier',
                            },
                          )
                        },
                        name: 'Hemelstier',
                        images: 'assets/images/ic_profile_hemelstier.png',
                      ),
                      ProfileAbjad(title: 'I'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Ishtar',
                              "profile_url":
                                  'assets/images/ic_profile_ishtar.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Ishtar',
                        images: 'assets/images/ic_profile_ishtar.png',
                      ),
                      ProfileAbjad(title: 'M'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Marduk',
                              "profile_url":
                                  'assets/images/ic_profile_marduk.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Marduk',
                        images: 'assets/images/ic_profile_marduk.png',
                      ),
                      ProfileAbjad(title: 'N'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Nanna',
                              "profile_url":
                                  'assets/images/ic_profile_nanna.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Nanna',
                        images: 'assets/images/ic_profile_nanna.png',
                      ),
                      ProfileAbjad(title: 'S'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Shamash',
                              "profile_url":
                                  'assets/images/ic_profile_shamash.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Shamash',
                        images: 'assets/images/ic_profile_shamash.png',
                      ),
                      ProfileAbjad(title: 'T'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.THEATER_GAME_CONTACT_CHAT_DETAIL,
                            arguments: {
                              "name": 'Tiamat',
                              "profile_url":
                                  'assets/images/ic_profile_tiamat.png',
                              "game": 'none',
                            },
                          )
                        },
                        name: 'Tiamat',
                        images: 'assets/images/ic_profile_tiamat.png',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}

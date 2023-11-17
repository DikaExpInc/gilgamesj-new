import 'package:gilgamesj_tour/app/modules/theater_game_call_humbaba_game/controllers/theater_game_call_humbaba_game_controller.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_call_humbaba_game/views/widgets/contact_widget.dart';
import 'package:gilgamesj_tour/app/modules/theater_game_call_humbaba_game/views/widgets/profile_abjad.dart';
import 'package:gilgamesj_tour/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CallHumbabaGameCallScreen
    extends GetView<TheaterGameCallHumbabaGameController> {
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
                    'Contacts',
                    style: const TextStyle(
                      fontFamily: 'Centrion',
                      fontSize: 46,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      // A
                      ProfileAbjad(title: 'A'),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Annu',
                              "profile_url":
                                  'assets/images/ic_profile_annu.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Enril',
                              "profile_url":
                                  'assets/images/ic_profile_enlil.png',
                              "audio": 'none',
                              "status": "not"
                            },
                          )
                        },
                        name: 'Enlil',
                        images: 'assets/images/ic_profile_enlil.png',
                      ),
                      ContactWidget(
                        onClick: () => {
                          Get.toNamed(
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Ereshkigal',
                              "profile_url":
                                  'assets/images/ic_profile_ereshkigal.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Hemelstier',
                              "profile_url":
                                  'assets/images/ic_profile_hemelstier.png',
                              "audio": 'voice-humbaba.wav',
                              "status": "real"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Ishtar',
                              "profile_url":
                                  'assets/images/ic_profile_ishtar.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Marduk',
                              "profile_url":
                                  'assets/images/ic_profile_marduk.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Nanna',
                              "profile_url":
                                  'assets/images/ic_profile_nanna.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Shamash',
                              "profile_url":
                                  'assets/images/ic_profile_shamash.png',
                              "audio": 'none',
                              "status": "not"
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
                            Routes.PHONE_CALL,
                            arguments: {
                              "name": 'Tiamat',
                              "profile_url":
                                  'assets/images/ic_profile_tiamat.png',
                              "audio": 'none',
                              "status": "not"
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

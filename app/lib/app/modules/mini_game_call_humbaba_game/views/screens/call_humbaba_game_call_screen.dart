import 'package:app/app/modules/mini_game_call_humbaba_game/controllers/mini_game_call_humbaba_game_controller.dart';
import 'package:app/app/modules/mini_game_call_humbaba_game/views/widgets/contact_widget.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CallHumbabaGameCallScreen
    extends GetView<MiniGameCallHumbabaGameController> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // A
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 64.0,
                      ),
                      child: Text(
                        'A',
                        style: const TextStyle(
                          fontFamily: 'Centrion',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    ContactWidget(
                      onClick: () => {
                        Get.toNamed(
                          Routes.PHONE_CALL,
                          arguments: {
                            "name": 'Test',
                            "profile_url": 'assets/images/ic_contact.png',
                            "audio": 'lock_code.mp3',
                            "status": "real"
                          },
                        )
                      },
                      name: 'Test',
                      images: 'assets/images/ic_contact.png',
                    ),
                    ContactWidget(
                      onClick: () => {
                        Get.toNamed(
                          Routes.PHONE_CALL,
                          arguments: {
                            "name": 'Test',
                            "profile_url": 'assets/images/ic_contact.png',
                            "audio": 'lock_code.mp3',
                            "status": "not"
                          },
                        )
                      },
                      name: 'Test',
                      images: 'assets/images/ic_contact.png',
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

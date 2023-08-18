import 'package:app/app/modules/phone_call/controllers/phone_call_controller.dart';
import 'package:app/app/modules/phone_call/views/widgets/countdown_timer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PhoneCallView extends GetView<PhoneCallController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return controller.contactData["status"] == "real"
        ? Scaffold(
            body: Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: controller.contactData["profile_url"] == "none"
                              ? DecorationImage(
                                  image: AssetImage(
                                    "assets/images/ic_contact.png",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    controller.contactData["profile_url"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${controller.contactData["name"]}",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CountdownTimerWidget(),
                    ],
                  ),
                  InkWell(
                    onTap: () => {Get.back(), controller.audioPlayer?.stop()},
                    child: Image.asset(
                      "assets/images/phone_discall.png",
                      width: 70,
                      height: 70,
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: controller.contactData["profile_url"] == "none"
                              ? DecorationImage(
                                  image: AssetImage(
                                    "assets/images/ic_contact.png",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    controller.contactData["profile_url"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "${controller.contactData["name"]}",
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Obx(() {
                        return controller.isIdleTimerRunning.value
                            ? Text(
                                "calling",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Can't Call",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              );
                      })
                    ],
                  ),
                  Obx(
                    () {
                      return controller.isIdleTimerRunning.value
                          ? InkWell(
                              onTap: () =>
                                  {Get.back(), controller.audioPlayer?.stop()},
                              child: Image.asset(
                                "assets/images/phone_discall.png",
                                width: 70,
                                height: 70,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Get.back(),
                                    controller.audioPlayer?.stop()
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_cancel.png",
                                        width: 70,
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {
                                    controller.audioPlayer?.stop(),
                                    controller.resetIdleTimer(),
                                  },
                                  child: Image.asset(
                                    "assets/images/phone_call.png",
                                    width: 70,
                                    height: 70,
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

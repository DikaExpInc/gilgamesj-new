import 'package:app/app/modules/bonus_home/controllers/bonus_home_controller.dart';
import 'package:app/app/modules/home/views/tabs/widgets/menu_widget.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BonusHomeView extends GetView<BonusHomeController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        // color: colors[0],
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.srcOver),
            image: CachedNetworkImageProvider(
              controller.box.read("background_url"),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: mHeight / 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => {Get.offAllNamed(Routes.START)},
                    child: Image.asset("assets/images/ic_logout.png"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/bonus_icon.png'),
                    SizedBox(
                      height: 42,
                    ),
                    Text(
                      "BONUS LEVEL",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    Container(
                      width: mWidth / 1.2, // Lebar 100%
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: MediaQuery.of(context).size.width > 600
                              ? 50
                              : 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg_task.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to BONUS Stage!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 42,
                          ),
                          Text(
                            "There is a secret Artifact hidden in the area. Use your AR camera to find the hidden special Artifact. You have 3 minutes to find the Artifact.",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mWidth /
                      (MediaQuery.of(context).size.width > 600 ? 10 : 15)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuWidget(
                        status: true,
                        icon: 'assets/images/ic_camera.png',
                        title: "AR Camera",
                        press: () => Get.toNamed(
                          Routes.BONUS_CAMERA,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80,
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

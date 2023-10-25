import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pre_game_photo_controller.dart';

class PreGamePhotoView extends StatelessWidget {
  final controller = Get.put(PreGamePhotoController());
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background3-black.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.imageFile.value != null
                  ? InkWell(
                      onTap: () {
                        controller.takePhoto();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Image.asset(
                          'assets/images/retake.png',
                          width: mWidth / 20,
                          height: mWidth / 20,
                        ),
                      ),
                    )
                  : Container(),
            ),
            Center(
              child: Obx(() => controller.imageFile.value != null
                  ? Image.file(
                      File(controller.imageFile.value!.path),
                      height: mHeight / 1.4,
                    )
                  : Text('Een foto nemen')),
            ),
            Obx(
              () => controller.imageFile.value != null
                  ? Center(
                      child: InkWell(
                        onTap: () => {controller.uploadphoto()},
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/upload.png',
                              width: mWidth / 20,
                              height: mWidth / 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Uploaden',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontFamily: 'Abel',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(),
            ),
            Obx(
              () => controller.imageFile.value != null
                  ? Center()
                  : InkWell(
                      onTap: () => {controller.takePhoto()},
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/get_picture.png',
                              width: mWidth / 10,
                              height: mWidth / 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Maak een selfie',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontFamily: 'Abel',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

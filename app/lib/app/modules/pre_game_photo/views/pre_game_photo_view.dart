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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.imageFile.value != null
                  ? Image.file(
                      File(controller.imageFile.value!.path),
                      height: mHeight / 1.4,
                    )
                  : Text('Get Photo')),
              ElevatedButton(
                onPressed: () => {},
                child: Text('Upload Photo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

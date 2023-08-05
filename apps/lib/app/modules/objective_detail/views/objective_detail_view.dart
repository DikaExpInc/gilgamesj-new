import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/objective_detail/controllers/objective_detail_controller.dart';
import 'package:gilgamesj/app/widgets/navbar_browser.dart';

class ObjectiveDetailView extends GetView<ObjectiveDetailController> {
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
                  image: AssetImage("assets/images/background3.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BabylonJSViewer(src: "assets/objects/Artefact.glb"),
            ),
          ],
        ),
      ),
    );
  }
}

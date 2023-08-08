import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gallery_image_detail_controller.dart';

class GalleryImageDetailView extends GetView<GalleryImageDetailController> {
  const GalleryImageDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GalleryImageDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GalleryImageDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

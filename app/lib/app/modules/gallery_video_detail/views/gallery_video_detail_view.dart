import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gallery_video_detail_controller.dart';

class GalleryVideoDetailView extends GetView<GalleryVideoDetailController> {
  const GalleryVideoDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GalleryVideoDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GalleryVideoDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

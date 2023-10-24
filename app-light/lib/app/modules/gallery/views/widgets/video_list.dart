import 'package:app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/gallery_video_model.dart';
import '../../../../utils/api.dart';
import '../../controllers/gallery_controller.dart';

class VideoListWidget extends GetView<GalleryController> {
  final String date;
  final GalleryVideoListModel? listVideo;
  final List<dynamic> listIsActiveTask;
  final List<dynamic> listAllTask;

  const VideoListWidget({
    Key? key,
    required this.date,
    required this.listVideo,
    required this.listIsActiveTask,
    required this.listAllTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List documentIds =
    //     listVideo.map((taskSnapshot) => taskSnapshot.id).toList();

    // List<bool> hasDetailIds = documentIds.map((id) {
    //   return listAllTask.any((task) => task['detail_id'] == id);
    // }).toList();

    // List taskIds = documentIds.map((id) {
    //   var task;
    //   try {
    //     task = listAllTask.firstWhere((task) => task['detail_id'] == id);
    //   } catch (_) {
    //     task = null;
    //   }
    //   return task != null ? task['id'] : '';
    // }).toList();

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${date}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: listVideo!.items!.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> arguments = {
                  'image':
                      '${SharedApi().imageUrl}${listVideo!.items![index].thumbnail}',
                  'video':
                      '${SharedApi().imageUrl}${listVideo!.items![index].video}',
                  'name': listVideo!.items![index].title,
                  'date': date,
                };
                return InkWell(
                  onTap: () => {
                    // if (listIsActiveTask[index])
                    // {controller.openTask(taskIds[index])},
                    Get.toNamed(Routes.GALLERY_VIDEO_DETAIL,
                        arguments: arguments)
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              '${SharedApi().imageUrl}${listVideo!.items![index].thumbnail!}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      listIsActiveTask[index]
                          ? Positioned(
                              top: 20, // Atur posisi vertikal ikon tanda seru
                              left:
                                  20, // Atur posisi horizontal ikon tanda seru
                              child: Icon(
                                Icons
                                    .error_outline, // Ganti dengan ikon tanda seru yang sesuai
                                size: 48,
                                color: Colors.red,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

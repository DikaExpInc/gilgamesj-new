import 'package:app/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoListWidget extends GetView<GalleryController> {
  final String date;
  final List<dynamic> listPhoto;
  final List<dynamic> listIsActiveTask;
  final List<dynamic> listAllTask;

  const PhotoListWidget({
    Key? key,
    required this.date,
    required this.listPhoto,
    required this.listIsActiveTask,
    required this.listAllTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List documentIds =
        listPhoto.map((taskSnapshot) => taskSnapshot.id).toList();

    List<dynamic> photos = listPhoto.map((taskSnapshot) {
      var taskData = taskSnapshot.data() as Map<String, dynamic>;
      var photoValue = taskData["downloadUrl"];
      return photoValue;
    }).toList();

    List<dynamic> names = listPhoto.map((taskSnapshot) {
      var taskData = taskSnapshot.data() as Map<String, dynamic>;
      var photoValue = taskData["name"];
      return photoValue;
    }).toList();

    List<bool> hasDetailIds = documentIds.map((id) {
      return listAllTask.any((task) => task['detail_id'] == id);
    }).toList();

    List taskIds = documentIds.map((id) {
      var task;
      try {
        task = listAllTask.firstWhere((task) => task['detail_id'] == id);
      } catch (_) {
        task = null;
      }
      return task != null ? task['id'] : '';
    }).toList();

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
              itemCount: photos.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> arguments = {
                  'image': photos[index],
                  'name': names[index],
                  'date': date,
                };
                return InkWell(
                  onTap: () => {
                    // if (listIsActiveTask[index])
                    // {controller.openTask(taskIds[index])},
                    Get.toNamed(Routes.GALLERY_IMAGE_DETAIL,
                        arguments: arguments)
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              photos[index],
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

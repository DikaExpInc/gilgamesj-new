import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/map/controllers/maps_controller.dart';

import 'package:latlong2/latlong.dart';

class MapView extends GetView<MapsController> {
  late double mWidth;
  late double mHeight;

  void _toggleBottomSheet(String title, String desc, String image) {
    Get.bottomSheet(
      Container(
        width: mWidth,
        height: mHeight / 3,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0), BlendMode.srcOver),
            image: AssetImage("assets/images/bg_bottom.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            children: [
              Container(
                width: mWidth * 30 / 100,
                child: CachedNetworkImage(
                  imageUrl: image,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${title}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: mWidth * 50 / 100,
                    child: Text(
                      "${desc}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    controller.toggleBottomSheetVisibility();
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(31.324167, 45.637222),
          zoom: 20.2,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'Konig Gilgamesj',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            tileBuilder: darkModeTileBuilder,
            backgroundColor: Colors.black,
            userAgentPackageName: 'com.example.app',
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan indikator loading jika masih menunggu hasil
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData) {
                // Mengakses data yang diterima dari stream
                QuerySnapshot<Map<String, dynamic>> querySnapshot =
                    snapshot.data!;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                    querySnapshot.docs;

                List<String> documentIds =
                    documents.map((snapshot) => snapshot.id).toList();

                Set taskDetailIds =
                    controller.tasks.map((task) => task["detail_id"]).toSet();

                // Membuat list boolean untuk menyimpan hasil pengecekan
                List<bool> hasDetailIds = documents
                    .map((taskSnapshot) =>
                        taskDetailIds.contains(taskSnapshot.id))
                    .toList();

                List taskIds = documentIds.map((id) {
                  var task;
                  try {
                    task = controller.tasks
                        .firstWhere((task) => task['detail_id'] == id);
                  } catch (_) {
                    task = null;
                  }
                  return task != null ? task['id'] : '';
                }).toList();

                // Lakukan perulangan untuk membuat marker
                List<Marker> markers = documents
                    .asMap()
                    .map((index, document) {
                      var mapData = document.data();

                      return MapEntry(
                        index,
                        Marker(
                          point:
                              LatLng(mapData['latitude'], mapData['longitude']),
                          width: 80,
                          height: 80,
                          builder: (context) => GestureDetector(
                            onTap: () => {
                              if (hasDetailIds[index])
                                {controller.openTask(taskIds[index])},
                              _toggleBottomSheet(
                                mapData['label'],
                                mapData['description'],
                                mapData['downloadUrl'],
                              )
                            },
                            child: Container(
                              child: Icon(Icons.location_on,
                                  color: hasDetailIds[index]
                                      ? Colors.redAccent
                                      : Colors.white,
                                  size: 120),
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList();

                // Tampilkan MarkerLayer dengan marker yang telah dibuat
                return MarkerLayer(markers: markers);
              } else if (snapshot.hasError) {
                // Menampilkan pesan error jika terjadi kesalahan
                return Text('Error: ${snapshot.error}');
              } else {
                // Menampilkan widget kosong jika tidak ada data yang ditemukan
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}

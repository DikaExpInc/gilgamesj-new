// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';

// import 'package:latlong2/latlong.dart';

// class MapView extends GetView<MapController> {
//   late double mWidth;
//   late double mHeight;

//   void _toggleBottomSheet(String title, String desc, String image) {
//     Get.bottomSheet(
//       Container(
//         width: mWidth,
//         height: mHeight / 3,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             colorFilter: ColorFilter.mode(
//                 Colors.black.withOpacity(0), BlendMode.srcOver),
//             image: AssetImage("assets/images/bg_bottom.png"),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//           child: Row(
//             children: [
//               Container(
//                 width: mWidth * 30 / 100,
//                 child: CachedNetworkImage(
//                   imageUrl: image,
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${title}",
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: mWidth * 50 / 100,
//                     child: Text(
//                       "${desc}",
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 8,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     mWidth = MediaQuery.of(context).size.width;
//     mHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(31.324167, 45.637222),
//           zoom: 20.2,
//         ),
//         nonRotatedChildren: [
//           AttributionWidget.defaultWidget(
//             source: 'Konig Gilgamesj',
//             onSourceTapped: null,
//           ),
//         ],
//         children: [
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//             tileBuilder: darkModeTileBuilder,
//             backgroundColor: Colors.black,
//             userAgentPackageName: 'com.expinc.gilgamesjtour',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Image Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(31.324167, 45.637222),
          zoom: 20,
        ),
        layers: [
          TileLayerOptions(
            tileProvider: FileTileProvider("assets/images/maps/MainMap.jpg"),
            maxZoom: 50,
          ),
        ],
      ),
    );
  }
}

class FileTileProvider extends TileProvider {
  final String assetPath;

  FileTileProvider(this.assetPath);

  ImageProvider createImage(TileLayerOptions options, Tile tile) {
    return AssetImage(assetPath);
  }

  @override
  ImageProvider<Object> getImage(Coords<num> coords, TileLayerOptions options) {
    return AssetImage(assetPath);
  }
}

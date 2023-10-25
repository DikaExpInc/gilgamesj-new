import 'dart:convert';

import '../data/gallery_video_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class GalleryVideoApi extends SharedApi {
  Future<GalleryVideoListModel> loadGalleryVideoAPI() async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/galleryvideo/get/bystage'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return GalleryVideoListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return GalleryVideoListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return GalleryVideoListModel.fromJson({"status": 404, "items": []});
    }
  }
}

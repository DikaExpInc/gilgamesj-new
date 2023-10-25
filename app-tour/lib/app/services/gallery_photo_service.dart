import 'dart:convert';

import '../data/gallery_photo_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class GalleryPhotoApi extends SharedApi {
  Future<GalleryPhotoListModel> loadGalleryPhotoAPI() async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/galleryphoto/get/bystage'),
          headers: getToken());
      stopLoading();

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return GalleryPhotoListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return GalleryPhotoListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return GalleryPhotoListModel.fromJson({"status": 404, "items": []});
    }
  }
}

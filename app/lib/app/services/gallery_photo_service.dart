import 'dart:convert';

import '../data/gallery_photo_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class GalleryPhotoApi extends SharedApi {
  Future<GalleryPhotoListModel> loadGalleryPhotoAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/galleryphoto/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return GalleryPhotoListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return GalleryPhotoListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return GalleryPhotoListModel.fromJson({"status": 404, "items": []});
    }
  }
}

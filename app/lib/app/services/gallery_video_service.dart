import 'dart:convert';

import '../data/gallery_video_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class GalleryVideoApi extends SharedApi {
  Future<GalleryVideoListModel> loadGalleryVideoAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/galleryvideo/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return GalleryVideoListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return GalleryVideoListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return GalleryVideoListModel.fromJson({"status": 404, "items": []});
    }
  }
}

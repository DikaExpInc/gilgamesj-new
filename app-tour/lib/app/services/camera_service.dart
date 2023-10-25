import 'dart:convert';

import '../data/camera_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class CameraApi extends SharedApi {
  Future<CameraListModel> loadCameraAPI() async {
    try {
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/camera/get/bystage'),
          headers: getToken());
      stopLoading();

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return CameraListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return CameraListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return CameraListModel.fromJson({"status": 404, "items": []});
    }
  }
}

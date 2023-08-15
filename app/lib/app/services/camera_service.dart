import 'dart:convert';

import '../data/camera_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class CameraApi extends SharedApi {
  Future<CameraListModel> loadCameraAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/camera/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return CameraListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return CameraListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return CameraListModel.fromJson({"status": 404, "items": []});
    }
  }
}

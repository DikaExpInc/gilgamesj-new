import 'dart:convert';

import '../data/map_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class MapApi extends SharedApi {
  Future<MapListModel> loadMapAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/map/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return MapListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return MapListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return MapListModel.fromJson({"status": 404, "items": []});
    }
  }
}

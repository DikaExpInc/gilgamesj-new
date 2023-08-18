import 'dart:convert';

import '../data/map_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class MapApi extends SharedApi {
  Future<MapListModel> loadMapAPI() async {
    try {
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/map/get/bystage'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return MapListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return MapListModel.fromJson({"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return MapListModel.fromJson({"status": 404, "items": []});
    }
  }
}

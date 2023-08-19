import 'dart:convert';

import '../data/light_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class LightApi extends SharedApi {
  Future<LightListModel> loadLightAPI() async {
    try {
      showLoading();
      var data =
          await http.get(Uri.parse(baseUrl + 'light'), headers: getToken());
      stopLoading();

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return LightListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return LightListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return LightListModel.fromJson({"status": 404, "items": []});
    }
  }
}

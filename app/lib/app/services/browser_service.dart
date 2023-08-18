import 'dart:convert';

import '../data/browser_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class BrowserApi extends SharedApi {
  Future<BrowserListModel> loadBrowserAPI() async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/browser/get/bystage'),
          headers: getToken());
      stopLoading();

      print(json.decode(data.body));

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return BrowserListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return BrowserListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return BrowserListModel.fromJson({"status": 404, "items": []});
    }
  }
}

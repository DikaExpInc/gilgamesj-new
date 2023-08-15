import 'dart:convert';

import '../data/browser_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class BrowserApi extends SharedApi {
  Future<BrowserListModel> loadBrowserAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/browser/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return BrowserListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return BrowserListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return BrowserListModel.fromJson({"status": 404, "items": []});
    }
  }
}

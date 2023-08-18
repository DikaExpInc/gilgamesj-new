import 'dart:convert';

import '../data/phone_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class PhoneApi extends SharedApi {
  Future<PhoneListModel> loadPhoneAPI() async {
    try {
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/phone/get/bystage'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return PhoneListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return PhoneListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return PhoneListModel.fromJson({"status": 404, "items": []});
    }
  }
}

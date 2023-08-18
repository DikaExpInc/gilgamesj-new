import 'dart:convert';

import '../data/contact_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class ContactApi extends SharedApi {
  Future<ContactListModel> loadContactAPI() async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/contact/get/bystage'),
          headers: getToken());
      stopLoading();

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return ContactListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return ContactListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return ContactListModel.fromJson({"status": 404, "items": []});
    }
  }
}

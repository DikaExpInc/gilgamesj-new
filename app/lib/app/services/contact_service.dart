import 'dart:convert';

import '../data/contact_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class ContactApi extends SharedApi {
  Future<ContactListModel> loadContactAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/contact/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return ContactListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return ContactListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return ContactListModel.fromJson({"status": 404, "items": []});
    }
  }
}

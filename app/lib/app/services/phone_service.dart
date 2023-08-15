import 'dart:convert';

import '../data/phone_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class PhoneApi extends SharedApi {
  Future<PhoneListModel> loadPhoneAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/phone/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return PhoneListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return PhoneListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return PhoneListModel.fromJson({"status": 404, "items": []});
    }
  }
}

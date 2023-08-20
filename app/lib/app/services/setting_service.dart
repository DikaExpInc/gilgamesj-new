import 'dart:convert';

import 'package:app/app/data/setting_model.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:app/app/widgets/message/errorMessage.dart';
import 'package:app/app/widgets/message/internetMessage.dart';
import 'package:http/http.dart' as http;

class SettingApi extends SharedApi {
  // Check Token API
  Future<SettingModel?> getSetting() async {
    try {
      var jsonData;
      var data = await http.get(
          Uri.parse(baseUrl + 'setting/64de3fd2843badaf9efc006b'),
          headers: getToken());
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['data']['status_code'] = 200;
        return SettingModel.fromJson(jsonData['data']);
      } else if (data.statusCode == 401) {
        showErrorMessage(jsonData['message']);
        return SettingModel.fromJson({"status_code": data.statusCode});
      } else {
        showErrorMessage("Ada yang salah");
        return SettingModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      showInternetMessage("Periksa koneksi internet anda");
      return SettingModel.fromJson({"status_code": 404});
    }
  }
}

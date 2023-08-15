import 'dart:convert';

import 'package:app/app/data/social_media_model.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/widgets/message/errorMessage.dart';
import 'package:http/http.dart' as http;

import '../widgets/loading.dart';

class SocialMediaApi extends SharedApi {
  Future<SocialMediaListModel> loadSocialMediaAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/socialmedia/get/bystage'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return SocialMediaListModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return SocialMediaListModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return SocialMediaListModel.fromJson({"status": 404, "items": []});
    }
  }
}

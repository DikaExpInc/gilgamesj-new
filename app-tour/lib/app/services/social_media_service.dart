import 'dart:convert';

import 'package:gilgamesj_tour/app/data/social_media_model.dart';
import 'package:gilgamesj_tour/app/utils/api.dart';
import 'package:http/http.dart' as http;

import '../widgets/loading.dart';
import '../widgets/message/errorMessage.dart';

class SocialMediaApi extends SharedApi {
  Future<SocialMediaListModel> loadSocialMediaAPI() async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse(baseUrl + 'stage/socialmedia/get/bystage'),
          headers: getToken());
      stopLoading();

      print(json.decode(data.body));

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return SocialMediaListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return SocialMediaListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return SocialMediaListModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<SocialMediaModel> likeSocialMediaAPI(id) async {
    try {
      showLoading();
      var data = await http.put(Uri.parse(baseUrl + 'socialmedia/like/${id}'),
          headers: getToken());
      stopLoading();
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['data']['status_code'] = 201;
        return SocialMediaModel.fromJson(jsonData['data']);
      } else {
        showErrorMessage(jsonData['message']);
        return SocialMediaModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return SocialMediaModel.fromJson({"status": 404, "items": []});
    }
  }
}

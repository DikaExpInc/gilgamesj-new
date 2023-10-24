import 'dart:convert';

import 'package:app/app/utils/api.dart';
import 'package:http/http.dart' as http;
import '../data/social_media_comment.dart';
import '../widgets/loading.dart';

class SocialMediaCommentApi extends SharedApi {
  Future<SocialMediaCommentListModel> loadSocialMediaCommentAPI(
      String sosmedId) async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse('${baseUrl}stage/socialmedia/get/bystage/${sosmedId}'),
          headers: getToken());
      stopLoading();

      print(json.decode(data.body));

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return SocialMediaCommentListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return SocialMediaCommentListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return SocialMediaCommentListModel.fromJson({"status": 404, "items": []});
    }
  }
}

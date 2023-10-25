import 'dart:convert';

import 'package:app/app/data/game2_model.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:app/app/widgets/message/internetMessage.dart';
import 'package:http/http.dart' as http;

class Game2Api extends SharedApi {
  // Register API
  Future<String> voteAPI(String id) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'game2/vote/' + id),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      print("data : " + jsonData.toString());
      if (data.statusCode == 200) {
        return "done";
      } else {
        return "error";
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Please check your connection");
      return "error";
    }
  }

  Future<String> resetAPI() async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'game2/reset'),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      print("data : " + jsonData.toString());
      if (data.statusCode == 200) {
        return "done";
      } else {
        return "error";
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Please check your connection");
      return "error";
    }
  }

  Future<Game2ListModel> loadGame2API() async {
    try {
      // showLoading();
      var data = await http.get(
        Uri.parse(baseUrl + 'game2'),
        headers: getToken(),
      );
      // stopLoading();
      var jsonData = json.decode(data.body);
      print("data : " + jsonData.toString());
      if (data.statusCode == 200) {
        return Game2ListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return Game2ListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return Game2ListModel.fromJson({"status": 404, "items": []});
    }
  }
}

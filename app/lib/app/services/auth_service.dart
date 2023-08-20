import 'dart:convert';

import 'package:app/app/data/player_model.dart';
import 'package:app/app/data/user_model.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:app/app/widgets/message/errorMessage.dart';
import 'package:app/app/widgets/message/internetMessage.dart';
import 'package:http/http.dart' as http;

class AuthApi extends SharedApi {
  // Check Token API
  Future<UserModel?> checkTokenApi(String token) async {
    try {
      var headers = {
        "Authorization": "Bearer " + token,
      };
      var jsonData;
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'user'), headers: headers);
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['status_code'] = 200;
        jsonData['access_token'] = token;
        jsonData['token_type'] = "bearer";
        return UserModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status_code": data.statusCode});
      } else {
        showErrorMessage("Ada yang salah");
        return UserModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status_code": 404});
    }
  }

  // Register API
  Future<UserModel?> registerAPI(String name, String totalPlayer) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'auth/signup'),
        body: {
          'username': name,
          'name': name,
          'email': name + '@gilgamesj.io',
          'password': 'password',
          'total_player': totalPlayer
        },
      );
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 201) {
        jsonData['data']['user']['status_code'] = 201;
        jsonData['data']['user']['access_token'] = jsonData['data']['token'];
        jsonData['data']['user']['token_type'] = jsonData['data']['type'];
        return UserModel.fromJson(jsonData['data']['user']);
      } else {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Please check your connection");
      return UserModel.fromJson({"status_code": 404});
    }
  }

  // Create Team Player API
  Future<PlayerModel?> addplayerAPI(String total_player) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(Uri.parse(baseUrl + 'auth/addplayer'),
          body: {
            'total_player': total_player,
          },
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 201) {
        jsonData['status_code'] = 201;
        return PlayerModel.fromJson(jsonData);
      } else {
        showErrorMessage(jsonData['message']);
        return PlayerModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Please check your connection");
      return PlayerModel.fromJson({"status_code": 404});
    }
  }

  Future<PlayerListModel> loadAllPlayerAPI() async {
    try {
      var data = await http.get(Uri.parse(baseUrl + 'players/all/byuser'),
          headers: getToken());

      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return PlayerListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return PlayerListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return PlayerListModel.fromJson({"status": 404, "items": []});
    }
  }
}

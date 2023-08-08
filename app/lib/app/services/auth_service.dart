import 'dart:convert';

import 'package:app/app/data/user_model.dart';
import 'package:app/app/utils/api.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:app/app/widgets/message/errorMessage.dart';
import 'package:app/app/widgets/message/internetMessage.dart';
import 'package:http/http.dart' as http;

class AuthApi extends SharedApi {
  // Login API
  Future<UserModel?> loginAPI(String email, String password) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'login'),
        body: {'email': email, 'password': password},
      );
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data']['status'] = 200;
        jsonData['data']['access_token'] = jsonData['access_token'];
        jsonData['data']['token_type'] = jsonData['token_type'];
        return UserModel.fromJson(jsonData['data']);
      } else {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }

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
        jsonData['status'] = 200;
        jsonData['access_token'] = token;
        jsonData['token_type'] = "bearer";
        return UserModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status": data.statusCode});
      } else {
        showErrorMessage("Ada yang salah");
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }

  // Login API
  Future<UserModel?> registerAPI(
      String name, String email, String password) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'register'),
        body: {'name': name, 'email': email, 'password': password},
      );
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data']['status'] = 200;
        jsonData['data']['access_token'] = jsonData['access_token'];
        jsonData['data']['token_type'] = jsonData['token_type'];
        return UserModel.fromJson(jsonData['data']);
      } else {
        showErrorMessage(jsonData['message']);
        return UserModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return UserModel.fromJson({"status": 404});
    }
  }
}

import 'dart:convert';

import 'package:app/app/data/player_model.dart';
import 'package:app/app/data/seat_model.dart';
import 'package:app/app/data/theater_seat_model.dart';
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
      var data = await http.get(Uri.parse(baseUrl + 'users/profile'),
          headers: headers);
      jsonData = json.decode(data.body);
      print(jsonData);
      if (data.statusCode == 200) {
        jsonData['status_code'] = 200;
        jsonData['access_token'] = token;
        jsonData['token_type'] = "bearer";
        return UserModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        return UserModel.fromJson({"status_code": data.statusCode});
      } else {
        return UserModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return UserModel.fromJson({"status_code": 404});
    }
  }

  // Register API
  Future<UserModel?> registerAPI(String totalPlayer, String role) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'auth/signup'),
        body: {
          'password': 'password',
          'total_player': totalPlayer,
          'user_type': role,
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

  Future<String> getSeatsAPI() async {
    try {
      // showLoading();
      var data = await http.post(
        Uri.parse(baseUrl + 'auth/getSeats'),
        headers: getToken(),
      );
      // stopLoading();
      if (data.statusCode == 200) {
        return "done";
      } else {
        return "error";
      }
    } on Exception catch (_) {
      stopLoading();
      return "error";
    }
  }

  Future<SeatModel?> loadSeatColRow() async {
    try {
      var jsonData;
      var data = await http.get(
        Uri.parse(baseUrl + 'auth/getrowcol'),
        headers: getToken(),
      );
      jsonData = json.decode(data.body);
      print(jsonData);
      if (data.statusCode == 200) {
        jsonData['status_code'] = 200;
        return SeatModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        return SeatModel.fromJson({"status_code": data.statusCode});
      } else {
        return SeatModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return SeatModel.fromJson({"status_code": 404});
    }
  }

  Future<TheaterSeatModel?> loadTheaterSeatColRow() async {
    try {
      var jsonData;
      var data = await http.post(
        Uri.parse(baseUrl + 'theater/seat'),
        headers: getToken(),
      );
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['status_code'] = 200;

        return TheaterSeatModel.fromJson(jsonData);
      } else if (data.statusCode == 401) {
        return TheaterSeatModel.fromJson({"status_code": data.statusCode});
      } else {
        return TheaterSeatModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return TheaterSeatModel.fromJson({"status_code": 404});
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

  // Change Player API
  Future<void> changeNamePlayers(List<Map<String, dynamic>> changes) async {
    final List<PlayerModel> updatedPlayers = [];

    try {
      showLoading();
      final data = await http.put(
        Uri.parse(baseUrl +
            'auth/changenameplayer'), // Ubah URL sesuai dengan endpoint yang sesuai
        body: {"changes": json.encode(changes)},
        headers: getToken(),
      );

      final jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        updatedPlayers.add(PlayerModel.fromJson(jsonData));
      } else {
        showErrorMessage(jsonData['message']);
      }

      stopLoading();
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Please check your connection");
    }
  }

  Future<int> getUsersAPI() async {
    try {
      var data = await http.get(
        Uri.parse(baseUrl + 'users/all'),
        headers: getToken(),
      );
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData['data'].length;
      } else {
        return 0;
      }
    } on Exception catch (_) {
      stopLoading();
      return 0;
    }
  }
}

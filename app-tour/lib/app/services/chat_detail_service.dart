import 'dart:convert';

import 'package:gilgamesj_tour/app/data/player_chat_model.dart';

import '../data/chat_detail_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class ChatDetailApi extends SharedApi {
  Future<ChatDetailListModel> getAnswerAPI(String chatId) async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse('${baseUrl}playerchats/${chatId}/getanswer'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return ChatDetailListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return ChatDetailListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return ChatDetailListModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<PlayerChatListModel> getChatAPI(String chatId) async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse('${baseUrl}playerchats/${chatId}/getchat'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return PlayerChatListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return PlayerChatListModel.fromJson(
            {"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return PlayerChatListModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<PlayerChatModel> initChatAPI(String chatId) async {
    try {
      var data = await http.post(
          Uri.parse('${baseUrl}playerchats/${chatId}/initchat'),
          headers: getToken());
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['data']['status_code'] = 200;
        return PlayerChatModel.fromJson(jsonData['data']);
      } else {
        return PlayerChatModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return PlayerChatModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<PlayerChatModel> replyChatAPI(String chatId) async {
    try {
      var data = await http.post(
          Uri.parse('${baseUrl}playerchats/${chatId}/replychat'),
          headers: getToken());
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['data']['status_code'] = 200;
        return PlayerChatModel.fromJson(jsonData['data']);
      } else {
        return PlayerChatModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return PlayerChatModel.fromJson({"status": 404, "items": []});
    }
  }

  Future<PlayerChatModel> answerChatAPI(String chatId, String id) async {
    try {
      var data = await http.post(
          Uri.parse('${baseUrl}playerchats/${chatId}/answerchat/${id}'),
          headers: getToken());
      var jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        jsonData['data']['status_code'] = 200;
        return PlayerChatModel.fromJson(jsonData['data']);
      } else {
        return PlayerChatModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return PlayerChatModel.fromJson({"status": 404, "items": []});
    }
  }
}

import 'dart:convert';

import '../data/chat_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class ChatApi extends SharedApi {
  Future<ChatListModel> loadChatAPI() async {
    try {
      showLoading();
      var data = await http.get(Uri.parse(baseUrl + 'stage/chat/get/bystage'),
          headers: getToken());
      stopLoading();
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return ChatListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return ChatListModel.fromJson({"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return ChatListModel.fromJson({"status": 404, "items": []});
    }
  }
}

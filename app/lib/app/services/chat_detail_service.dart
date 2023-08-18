import 'dart:convert';

import '../data/chat_detail_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;

class ChatDetailApi extends SharedApi {
  Future<ChatDetailListModel> loadChatDetailAPI(String chatId) async {
    try {
      showLoading();
      var data = await http.get(
          Uri.parse('${baseUrl}stage/chat/get/bystage/${chatId}'),
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
}

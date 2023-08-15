import 'dart:convert';

import '../data/task_model.dart';
import '../utils/api.dart';
import '../widgets/loading.dart';
import 'package:http/http.dart' as http;
import '../widgets/message/errorMessage.dart';

class TaskApi extends SharedApi {
  Future<TaskListModel> loadTaskAPI(String stage_id) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.get(
          Uri.parse('${baseUrl}task/${stage_id}/findplayer'),
          headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return TaskListModel.fromJson(
            {"status": 200, "items": jsonData['data']});
      } else {
        return TaskListModel.fromJson({"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return TaskListModel.fromJson({"status": 404, "items": []});
    }
  }
}

import 'dart:convert';

import 'package:app/app/utils/api.dart';
import 'package:http/http.dart' as http;

import '../data/stage_model.dart';

class StageApi extends SharedApi {
  Future<StageModel> loadStageAPI() async {
    try {
      var data =
          await http.get(Uri.parse(baseUrl + 'stage'), headers: getToken());
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        return StageModel.fromJson(
            {"status_code": 200, "items": jsonData['data']});
      } else {
        return StageModel.fromJson({"status": data.statusCode, "items": []});
      }
    } on Exception catch (_) {
      return StageModel.fromJson({"status": 404, "items": []});
    }
  }
}

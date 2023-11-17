import 'dart:convert';

import 'package:gilgamesj_tour/app/utils/api.dart';
import 'package:gilgamesj_tour/app/widgets/message/errorMessage.dart';
import 'package:http/http.dart' as http;

import '../data/stage_model.dart';
import '../widgets/loading.dart';

class StageApi extends SharedApi {
  Future<StageModel> loadStageAPI() async {
    try {
      var jsonData;
      showLoading();
      var data =
          await http.get(Uri.parse(baseUrl + 'stage'), headers: getToken());
      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        jsonData['data'][0]['status_code'] = 200;
        return StageModel.fromJson(jsonData['data'][0]);
      } else {
        showErrorMessage(jsonData['message']);
        return StageModel.fromJson({"status_code": data.statusCode});
      }
    } on Exception catch (_) {
      return StageModel.fromJson({"status": 404, "items": []});
    }
  }
}

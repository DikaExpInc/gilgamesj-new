import 'package:gilgamesj_tour/app/utils/app_config.dart';
import 'package:get_storage/get_storage.dart';

class SharedApi {
  String imageUrl = "http://${AppConfig().ipaddr}:4000/";
  String baseUrl = "http://${AppConfig().ipaddr}:4000/api/v1/";
  Map<String, String> getToken() {
    final box = GetStorage();

    String? token = box.read("token");
    if (token != null)
      return {
        "Authorization": "Bearer " + token,
      };
    return {
      "Authorization": "Bearer " + "BadToken",
    };
  }
}

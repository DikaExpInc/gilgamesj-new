import 'package:get_storage/get_storage.dart';

class SharedApi {
  String imageUrl = "http://posts.doyatama.com";
  String baseUrl = "http://posts.doyatama.com/api/";
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

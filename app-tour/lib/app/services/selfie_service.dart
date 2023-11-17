import 'dart:convert';

import 'package:gilgamesj_tour/app/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SelfieApi extends SharedApi {
  Future<String> uploadAPI(XFile? imageFile, int fileLength) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + 'selfie/create'),
      );

      var headers = getToken();
      print('Token Header: $headers');
      request.headers.addAll(headers);

      request.files.add(http.MultipartFile(
        'image',
        http.ByteStream.fromBytes(
            List<int>.from(await imageFile!.readAsBytes())),
        fileLength,
        filename: 'image.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonData;
        var responseJson = await response.stream.bytesToString();
        jsonData = json.decode(responseJson);
        return "done";
      } else {
        return "error";
      }
    } on Exception catch (_) {
      return "error";
    }
  }
}

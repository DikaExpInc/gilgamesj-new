import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PreGamePhotoController extends GetxController {
  @override
  void onInit() {
    takePhoto();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var imageFile = Rx<XFile?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFile.value = photo;
    }
  }
}

import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/services/selfie_service.dart';
import 'package:app/app/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class PreGamePhotoController extends GetxController {
  final Map<String, dynamic> argument = Get.arguments;

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

  uploadphoto() async {
    update();
    showLoading();
    if (imageFile.value != null) {
      List<int> bytes = await imageFile.value!.readAsBytes();
      var length = bytes.length;
      await SelfieApi().uploadAPI(imageFile.value, length);
      GetStorage().write('pre-game-${argument['id']}', 'ada');
      Get.offAllNamed(Routes.PRE_GAME_SUCCESS);
    }
    update();
    stopLoading();
  }
}

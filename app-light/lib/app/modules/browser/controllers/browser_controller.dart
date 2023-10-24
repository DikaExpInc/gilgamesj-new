import 'package:app/app/data/browser_model.dart';
import 'package:app/app/services/browser_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../widgets/loading.dart';

class BrowserController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

  @override
  void onInit() {
    super.onInit();
    loadBrowser();
  }

  loadBrowser() async {
    update();
    showLoading();
    BrowserListModel browser = await BrowserApi().loadBrowserAPI();
    pageAllController.updateBrowser(browser);
    update();
    stopLoading();
    if (browser.statusCode == 200) {
    } else if (browser.statusCode == 204) {
      print("Empty");
    } else if (browser.statusCode == 404) {
      update();
    } else if (browser.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}

import 'package:get/get.dart';

import '../controllers/create_team_controller.dart';

class CreateTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTeamController>(
      () => CreateTeamController(),
    );
  }
}

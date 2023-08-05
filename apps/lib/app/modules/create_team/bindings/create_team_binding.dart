import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/create_team/controllers/create_team_controller.dart';

class CreateTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTeamController>(
      () => CreateTeamController(),
    );
  }
}

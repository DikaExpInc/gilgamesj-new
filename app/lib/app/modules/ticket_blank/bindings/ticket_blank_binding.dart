import 'package:get/get.dart';

import '../controllers/ticket_blank_controller.dart';

class TicketBlankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketBlankController>(
      () => TicketBlankController(),
    );
  }
}

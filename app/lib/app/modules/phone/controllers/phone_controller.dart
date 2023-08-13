import 'package:app/app/modules/phone/views/tabs/contact_tab.dart';
import 'package:app/app/modules/phone/views/tabs/phone_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhoneController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RxString phoneNumber;
  final box = GetStorage();

  final List<GetView> myTabs = <GetView>[
    PhoneTab(),
    ContactTab(),
  ];

  late TabController tabController;
  int activeTabIndex = 1;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    phoneNumber = "0".obs;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void updatePhoneNumber(String digit) {
    phoneNumber.value = phoneNumber.value + digit;
  }

  void deleteDigit() {
    if (phoneNumber.value.length > 1) {
      phoneNumber.value =
          phoneNumber.value.substring(0, phoneNumber.value.length - 1);
    } else {
      phoneNumber.value = "";
    }
  }

  void clearDigit() {
    phoneNumber.value = "";
  }
}

import 'package:gilgamesj_tour/app/data/contact_model.dart';
import 'package:gilgamesj_tour/app/data/phone_model.dart';
import 'package:gilgamesj_tour/app/modules/phone/views/tabs/contact_tab.dart';
import 'package:gilgamesj_tour/app/modules/phone/views/tabs/phone_tab.dart';
import 'package:gilgamesj_tour/app/services/contact_service.dart';
import 'package:gilgamesj_tour/app/services/phone_service.dart';
import 'package:gilgamesj_tour/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/page_all_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/loading.dart';

class PhoneController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  late RxString phoneNumber;
  final box = GetStorage();
  final PageAllController pageAllController = Get.find<PageAllController>();

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
    loadPhone();
    loadContact();
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

  void call() {
    // Set taskDetailIds =
    //     pageAllController.tasks!.items!.map((task) => task.detailId).toSet();

    // Membuat list boolean untuk menyimpan hasil pengecekan
    // List<bool> hasDetailIds = pageAllController.phones!.items!
    //     .map((phoneSnapshot) => taskDetailIds.contains(phoneSnapshot.sId))
    //     .toList();

    List<PhoneModel> filteredPhoneNumber = pageAllController.phones!.items!
        .where((contactSnapshot) => phoneNumber == contactSnapshot.phone_number)
        .toList();

    List<ContactModel> filteredContacts = pageAllController.contacts!.items!
        .where(
            (contactSnapshot) => phoneNumber == contactSnapshot.contact_number)
        .toList();

    if (filteredPhoneNumber.length > 0) {
      Get.toNamed(
        Routes.PHONE_CALL,
        arguments: {
          "name": filteredPhoneNumber[0].name,
          "profile_url":
              '${SharedApi().imageUrl}${filteredPhoneNumber[0].profile}',
          "audio": '${SharedApi().imageUrl}${filteredPhoneNumber[0].audio}',
          "status": "real"
        },
      );
    } else if (filteredContacts.length > 0) {
      Get.toNamed(
        Routes.PHONE_CALL,
        arguments: {
          "name": filteredContacts[0].name,
          "profile_url":
              '${SharedApi().imageUrl}${filteredContacts[0].profile}',
          "audio": '${SharedApi().imageUrl}${filteredContacts[0].audio}',
          "status": "real"
        },
      );
    } else {
      Get.toNamed(
        Routes.PHONE_CALL,
        arguments: {
          "name": 'unknown',
          "profile_url": 'none',
          "audio": 'none',
          "status": "fake"
        },
      );
    }
  }

  loadPhone() async {
    update();
    showLoading();
    PhoneListModel phone = await PhoneApi().loadPhoneAPI();
    pageAllController.updatePhone(phone);
    update();
    stopLoading();
    if (phone.statusCode == 200) {
    } else if (phone.statusCode == 204) {
      print("Empty");
    } else if (phone.statusCode == 404) {
      update();
    } else if (phone.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  loadContact() async {
    update();
    showLoading();
    ContactListModel contact = await ContactApi().loadContactAPI();
    pageAllController.updateContact(contact);
    update();
    stopLoading();
    if (contact.statusCode == 200) {
    } else if (contact.statusCode == 204) {
      print("Empty");
    } else if (contact.statusCode == 404) {
      update();
    } else if (contact.statusCode == 401) {
    } else {
      print("someting wrong 400");
    }
  }
}

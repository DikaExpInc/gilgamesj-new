import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gilgamesj/app/modules/gallery/views/widgets/photo_list.dart';
import 'package:gilgamesj/app/modules/phone/controllers/phone_controller.dart';
import 'package:gilgamesj/app/modules/phone/views/widgets/phone_widget.dart';
import 'package:gilgamesj/app/routes/app_pages.dart';

class ContactTab extends GetView<PhoneController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: mWidth,
              height: mHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0), BlendMode.srcOver),
                  image: AssetImage("assets/images/background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamContact(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            listContact = snapshot.data!.docs;
                        List<String> documentIds =
                            listContact.map((snapshot) => snapshot.id).toList();

                        return listContact.length > 0
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 142,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 64.0,
                                      vertical: 16.0,
                                    ),
                                    child: ListView.separated(
                                        itemCount: listContact.length,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 16),
                                        itemBuilder: (context, index) {
                                          var contactData =
                                              listContact[index].data();
                                          return PhoneWidget(
                                              onClick: () => {
                                                    Get.toNamed(
                                                      Routes.PHONE_CALL,
                                                      arguments: {
                                                        "name":
                                                            contactData['name'],
                                                        "profile_url":
                                                            contactData[
                                                                'profileUrl'],
                                                        "status": "real"
                                                      },
                                                    )
                                                  },
                                              name: contactData['name'],
                                              images:
                                                  contactData['profileUrl']);
                                        }),
                                  ),
                                ],
                              )
                            : Container(
                                child: Center(
                                  child: Text("Data history masih belum ada"),
                                ),
                              );
                      default:
                        return SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

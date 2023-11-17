import 'package:gilgamesj_tour/app/modules/phone/controllers/phone_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/api.dart';
import '../widgets/phone_widget.dart';

// ignore: must_be_immutable
class ContactTab extends GetView<PhoneController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<PhoneController>(builder: (controller) {
      if (controller.pageAllController.contacts?.statusCode == 200) {
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
                  child:
                      controller.pageAllController.contacts!.items!.length > 0
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
                                    itemCount: controller.pageAllController
                                        .contacts!.items!.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 16),
                                    itemBuilder: (context, index) {
                                      var contactData = controller
                                          .pageAllController
                                          .contacts!
                                          .items![index];
                                      return PhoneWidget(
                                        onClick: () => {
                                          Get.toNamed(
                                            Routes.PHONE_CALL,
                                            arguments: {
                                              "name": '${contactData.name}',
                                              "profile_url":
                                                  '${SharedApi().imageUrl}${contactData.profile}',
                                              "audio":
                                                  '${SharedApi().imageUrl}${contactData.audio}',
                                              "status": "real"
                                            },
                                          )
                                        },
                                        name: '${contactData.name}',
                                        images:
                                            '${SharedApi().imageUrl}${contactData.profile}',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              child: Center(
                                child: Text("Data history masih belum ada"),
                              ),
                            ),
                ),
              ],
            ),
          ),
        );
      } else
        return Container();
    });
  }
}

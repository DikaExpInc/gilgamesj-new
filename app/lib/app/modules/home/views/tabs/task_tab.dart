import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/views/tabs/widgets/task_widget.dart';
import 'package:app/app/widgets/toast/custom_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../widgets/no_data.dart';

class TaskTab extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;

  final PageController hPagerController;

  TaskTab({required this.hPagerController});

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: mHeight / 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => hPagerController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                child: Image.asset("assets/images/ic_back2.png"),
              ),
              // InkWell(
              //   onTap: () => controller.logout(),
              //   child: Image.asset("assets/images/ic_logout.png"),
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: mHeight / 25, left: mWidth / 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Opdrachten",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      height: 3.0,
                      width: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: GetBuilder<HomeController>(
            builder: (controller) =>
                controller.pageAllController.tasks?.statusCode == 200
                    ? controller.pageAllController.tasks?.items!.length != 0
                        ? Padding(
                            padding: EdgeInsets.all(mWidth / 10),
                            child: ListView.builder(
                              itemCount: controller
                                  .pageAllController.tasks?.items!.length,
                              itemBuilder: (context, index) {
                                return TaskWidget(
                                  status: false,
                                  title: controller.pageAllController.tasks!
                                      .items![index].title
                                      .toString(),
                                  desc: controller.pageAllController.tasks!
                                      .items![index].description
                                      .toString(),
                                  press: () {
                                    CustomToast.successToast(
                                      'Task',
                                      'Task: ${controller.pageAllController.tasks?.items![index].title} \n Description: ${controller.pageAllController.tasks?.items![index].description}',
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : NoData()
                    : controller.pageAllController.tasks?.statusCode == 204
                        ? Container(
                            child: Text("Empty"),
                          )
                        : NoData(),
          ),
        ),
      ],
    );
  }
}

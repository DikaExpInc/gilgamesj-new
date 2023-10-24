import 'package:app/app/modules/social_media/views/widgets/feed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/social_media_controller.dart';

// ignore: must_be_immutable
class SocialMediaView extends GetView<SocialMediaController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return GetBuilder<SocialMediaController>(builder: (controller) {
      if (controller.pageAllController.socialMedias?.statusCode == 200) {
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 64.0),
                    child: controller
                                .pageAllController.socialMedias!.items!.length >
                            0
                        ? ListView.separated(
                            itemCount: controller
                                .pageAllController.socialMedias!.items!.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              var sosmedData = controller.pageAllController
                                  .socialMedias!.items![index];
                              return FeedWidget(
                                id: sosmedData.sId.toString(),
                                profileUrl: sosmedData.profile.toString(),
                                date: sosmedData.date.toString(),
                                mediaUrl: sosmedData.postImage.toString(),
                                like: int.parse(sosmedData.like.toString()),
                                name: sosmedData.name.toString(),
                                description: sosmedData.description.toString(),
                                location: sosmedData.location.toString(),
                              );
                            },
                          )
                        : Container(
                            child: Center(
                              child: Text(
                                "There is no social media data yet",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
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

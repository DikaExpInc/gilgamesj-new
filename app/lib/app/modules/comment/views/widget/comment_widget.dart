import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String profileUrl;
  final String name;
  final String comment;
  const CommentWidget({
    Key? key,
    required this.profileUrl,
    required this.name,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    '${profileUrl}',
                  ),
                  radius: 20,
                ),
                SizedBox(
                  width: 24,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width / 1.6, // Lebar 100%
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal:
                          MediaQuery.of(context).size.width > 600 ? 50 : 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_task.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${name}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${comment}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

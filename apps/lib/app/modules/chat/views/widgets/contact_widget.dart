import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gilgamesj/app/style/app_color.dart';

class ContactWidget extends StatelessWidget {
  final String profile;
  final String name;
  final String last_chat;
  final String last_chat_time;
  final int total_chat_unread;
  final VoidCallback press;

  const ContactWidget({
    Key? key,
    required this.profile,
    required this.name,
    required this.last_chat,
    required this.last_chat_time,
    required this.total_chat_unread,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 600 ? 64.0 : 30,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        '${profile}',
                      ),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${last_chat}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${last_chat_time}',
                      style: TextStyle(
                        color: AppColor.primary,
                      ),
                    ),
                    total_chat_unread != 0
                        ? Container(
                            width: 16, // Ukuran lebar lingkaran
                            height: 16, // Ukuran tinggi lingkaran
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle, // Mengatur bentuk menjadi lingkaran
                              color: AppColor
                                  .primary, // Warna latar belakang lingkaran
                            ),
                            child: Center(
                              child: Text(
                                '${total_chat_unread}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

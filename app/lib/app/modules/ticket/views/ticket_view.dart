import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: mWidth,
        height: mHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background3-black.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'My Ticket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Check your seats in your ticket below',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => controller.isVisible.value
                      ? Text(
                          'Please standy on this screen',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        )
                      : Text(
                          'Please standy on this screen',
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 36,
                          ),
                        ), // Teks tidak terlihat
                ),
              ],
            ),
            Container(
              width: mWidth / 1.2,
              height: mHeight / 2,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Radius border
                border: Border.all(
                  color: Colors.white, // Warna border putih
                  width: 2.0, // Lebar border
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Konig Gilgamesj',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date & Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Theater',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Monday',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        'Theater Name',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '6:45 PM',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white, // Warna putih
                    thickness: 2, // Ketebalan garis
                    height: 50, // Tinggi garis
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${GetStorage().read('teamName')}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: mHeight / 5,
                            width: mWidth / 2,
                            child: Expanded(
                              child: ListView.builder(
                                itemCount:
                                    int.parse(GetStorage().read('totalPlayer')),
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${GetStorage().read('played_name_${index}')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.white, // Warna garis vertikal
                        thickness: 2, // Ketebalan garis vertikal
                        indent: 10, // Jarak dari bagian atas
                        endIndent: 10, // Jarak dari bagian bawah
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Seat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: mHeight / 5,
                            width: mWidth / 7,
                            child: Expanded(
                              child: ListView.builder(
                                itemCount:
                                    int.parse(GetStorage().read('totalPlayer')),
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${GetStorage().read('seat_${index}')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                    ),
                                    textAlign: TextAlign.end,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

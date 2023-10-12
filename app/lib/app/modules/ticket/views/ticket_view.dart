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
    return GetBuilder<TicketController>(builder: (controller) {
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
              Container(
                width: mWidth / 1.1,
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
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Ga nu naar het theater toe en ga zitten op je plek',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                                  itemCount: int.parse(
                                      GetStorage().read('totalPlayer')),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Stoel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: mHeight / 6,
                              width: mWidth / 7,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: int.parse(
                                      GetStorage().read('totalPlayer')),
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${GetStorage().read('stoel_${index}')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Rij',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: mHeight / 6,
                              width: mWidth / 7,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: int.parse(
                                      GetStorage().read('totalPlayer')),
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${GetStorage().read('rij_${index}')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                      ),
                                      textAlign: TextAlign.center,
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
    });
  }
}

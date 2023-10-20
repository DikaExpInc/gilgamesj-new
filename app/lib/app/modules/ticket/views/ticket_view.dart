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
              Text(
                '${GetStorage().read('status_seat_tablet')}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 40),
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
                      height: 20,
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
                              '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                int.parse(GetStorage().read('totalPlayer')),
                                (index) => Text(
                                  '${GetStorage().read('played_name_$index')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(),
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
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                int.parse(GetStorage().read('totalPlayer')),
                                (index) => Text(
                                  '${GetStorage().read('stoel_$index')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
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
                              height: 20,
                            ),
                            Column(
                              children: List.generate(
                                int.parse(GetStorage().read('totalPlayer')),
                                (index) => Text(
                                  '${GetStorage().read('rij_$index')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/podium.png'),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(controller.col.value, (indexA) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        controller.row.value,
                        (indexB) {
                          return buildSeat(indexA + 1, indexB + 1);
                        },
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildSeat(int rows, int cols) {
    bool isActive = false;
    for (var i = 0; i < int.parse(GetStorage().read('totalPlayer')); i++) {
      String? colFromStorage = GetStorage().read('rij_$i');
      String? rowFromStorage = GetStorage().read('stoel_$i');
      if (rowFromStorage == rows.toString() &&
          colFromStorage == cols.toString()) {
        isActive = true;
      }
    }

    return Padding(
      padding: EdgeInsets.all(1),
      child: Image.asset(
        isActive ? 'assets/images/seat-active.png' : 'assets/images/seat.png',
        width: 40,
        height: 40,
      ),
    );
  }
}

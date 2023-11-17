import 'package:gilgamesj_tour/app/modules/scan_qr/controllers/scan_qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FillQrTab extends GetView<ScanQrController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1C1C1C),
        body: Stack(
          children: [
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/barcode.png',
                          width: MediaQuery.sizeOf(context).width / 3,
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Voer hier de code in:",
                          style: TextStyle(
                            fontFamily: 'Abel',
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: TextField(
                            controller: controller.inputCodeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Code ******',
                              contentPadding: EdgeInsets.all(15.0),
                              filled:
                                  true, // Mengaktifkan latar belakang berwarna
                              fillColor: Colors.white, // Warna latar belakang
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Color(0xffffffff),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        controller.onSubmit();
                      },
                      child: Text(
                        "Go",
                        style: TextStyle(
                          fontFamily: 'Abel',
                          color: Colors.white,
                          fontSize: 42,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isWrongFill.value
                  ? Positioned(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(40),
                          height: MediaQuery.sizeOf(context).height / 4,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            border: Border.all(
                                color: Colors.white,
                                width: 2.0), // Mengatur border putih
                            borderRadius: BorderRadius.circular(
                                20.0), // Memberikan radius
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Oops! verkeerde QR code.\nProbeer een ander museumstuk.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 36),
                                textAlign: TextAlign.center,
                              ),
                              InkWell(
                                onTap: () => {
                                  controller.isWrongFill.value = false,
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 4,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal:
                                          MediaQuery.of(context).size.width >
                                                  600
                                              ? 50
                                              : 20),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/bg_btn.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "DOORGAAN",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  600
                                              ? 16
                                              : 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ));
  }
}

import 'package:app/app/modules/scan_qr/views/tabs/fill_qr_tab.dart';
import 'package:app/app/modules/scan_qr/views/tabs/scan_qr_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Scan de code of vulHem in.",
          style: TextStyle(
            fontFamily: 'Abel',
            color: Colors.white,
            fontSize: 36,
          ),
        )),
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
        toolbarHeight: 200,
        bottom: TabBar(
          controller: controller.tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4.0,
              color: Color(0xffEFB523),
            ), // Mengatur tebal dan warna border
            insets: EdgeInsets.symmetric(
                horizontal: 16.0), // Jarak horizontal dari border
          ),
          labelColor: Color(0xffEFB523),
          labelStyle: TextStyle(
            fontFamily: 'Abel',
            fontWeight: FontWeight.bold,
            fontSize: 32.0,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Abel',
            fontWeight: FontWeight.normal,
            fontSize: 32.0,
          ),
          unselectedLabelColor: Colors.grey[600],
          tabs: [
            Tab(text: "Scan QR"),
            Tab(text: "Code invoeren"),
          ],
        ),
      ),
      body: new TabBarView(
        controller: controller.tabController,
        children: <Widget>[
          ScanQrTab(),
          FillQrTab(),
        ],
      ),
    );
  }
}

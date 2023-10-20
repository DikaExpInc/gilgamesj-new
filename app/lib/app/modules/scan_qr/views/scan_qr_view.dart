import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(child: _buildQrView(context)),
          Center(
            child: Positioned(
                child: Container(
              margin: EdgeInsets.only(bottom: 500),
              child: Text(
                'Scan QR Code',
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            )),
          ),
          Obx(
            () => controller.isWrong.value
                ? Center(
                    child: Positioned(
                        child: Container(
                      padding: EdgeInsets.all(40),
                      height: MediaQuery.sizeOf(context).height / 4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(230, 0, 0, 0),
                        border: Border.all(
                            color: Colors.white,
                            width: 2.0), // Mengatur border putih
                        borderRadius:
                            BorderRadius.circular(20.0), // Memberikan radius
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Oeps! Je scant de verkeerde QR,\nProbeer het opnieuw',
                            style: TextStyle(color: Colors.white, fontSize: 36),
                            textAlign: TextAlign.center,
                          ),
                          InkWell(
                            onTap: () => {
                              controller.isWrong.value = false,
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width / 4,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal:
                                      MediaQuery.of(context).size.width > 600
                                          ? 50
                                          : 20),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/bg_btn.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "DOORGAAN",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
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
                    )),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: controller.onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}

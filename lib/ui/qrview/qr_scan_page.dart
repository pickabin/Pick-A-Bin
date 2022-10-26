import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(
              bottom: 10,
              child: buildResult()
            ),
            Positioned(
              top: 10,
              child: buildControlButtons(context),
            )
          ],
        ),
      ),
   );
  }

  Widget buildResult() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Text(
        result != null ? 'Barcode Type: ${describeEnum(result!.format)}   Code: ${result!.code}' : 'Scan a code',
        
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildControlButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot) {
              return Icon(snapshot.data ?? false ? Icons.flash_on : Icons.flash_off);
            },
          ),
          onPressed: () async {
            await controller?.toggleFlash();
            setState(() {});
          },
        ),
        IconButton(
          icon: FutureBuilder(
            future: controller?.getCameraInfo(),
            builder: (context, snapshot) {
                return Icon(Icons.switch_camera);            
            },
          ),
          onPressed: () async {
            await controller?.flipCamera();
            setState(() {});
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget buildQrView(BuildContext context){
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 25,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.resumeCamera();
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        result = barcode;
      });
    });
  }

}
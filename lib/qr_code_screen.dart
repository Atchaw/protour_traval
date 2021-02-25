import 'package:flutter/material.dart';
import 'package:protour_traval/app_theme.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class QrCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Qr Code'),
        ),
        body: Center(
          child: PrettyQr(
              image: AssetImage('assets/images/qr_logo.png'),
              typeNumber: 3,
              size: 300,
              data: 'Protour Travel',
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true),
        ),
      ),
    );
  }
}

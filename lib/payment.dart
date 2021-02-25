import 'package:flutter/material.dart';
import 'package:protour_traval/app_theme.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
//import 'package:file_picker/file_picker.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File _file;
  Future getFile() async {
    /*
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.files.single.path);
      } else {
        print('No file selected.');
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Center(
          child: _file == null ? Text('No file selected.') : Text(_file.path),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getFile,
          tooltip: 'Pick Image',
          child: Icon(Icons.note_add),
        ),
      ),
    );
  }
}

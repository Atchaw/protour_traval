import 'package:flutter/material.dart';
import 'package:protour_traval/app_theme.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  color: AppTheme.nearlyDarkYellow,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.nearlyDarkYellow.withOpacity(0.5),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 6),
                            child: Text(
                              ' PAYMENT PAR CPP',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                                letterSpacing: 0.0,
                                color: AppTheme.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.payment,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' Utilise ces infos pour verser \n RIP: XXXX-XXXX-XXXX-XXXX\n CCP: XXXX-XXXX-XXXX-XXXX\n Apres prede une photo de reccue',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 0.0,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 80,
                      ),
                    ),
                  ],
                )),
              ),
            ),
            onTap: () {
              getImage();
            },
          ),
        ), /*  child:
              _image == null ? Text('No image selected.') : Image.file(_image),
        ),*/
        /*
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
        */
      ),
    );
  }
}

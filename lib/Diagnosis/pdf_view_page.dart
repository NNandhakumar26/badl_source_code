import 'package:badl_app/diagnosis/first_page.dart';
import 'package:badl_app/network/network.dart';
import 'package:badl_app/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../pdf_page.dart';

class PDFViewPage extends StatelessWidget {
  final Map<String, dynamic> userInput;

  PDFViewPage({required this.userInput});

  Future<dynamic> addUser() async {
    // await Network.addReportToDb(userInput.map(
    //     (key, value) => MapEntry(key, (value != null) ? value.toJson() : '')));

    return await PdfPage().generate(userInput);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: addUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('*** Generated The PDF ***');
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Get.offAll(FirstPage());
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.white.withOpacity(0.87),
                ),
              ),
              shadowColor: Style.nearlyDarkBlue.withOpacity(0.30),
              backgroundColor: Style.nearlyDarkBlue.withOpacity(0.87),
              elevation: 0,
              centerTitle: false,
              title: Text(
                'PDF View',
                style: Style.bodyText1.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                child: Center(
                  child: PdfPreview(
                    build: (format) => snapshot.data,
                  ),
                ),
              ),
            ),
          );
        } else
          return Container(
            color: Colors.white,
            height: Get.height,
            width: Get.width,
            child: Center(
              child: CircularProgressIndicator(
                color: Style.nearlyDarkBlue,
              ),
            ),
          );
      },
    );
  }
}

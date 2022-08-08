import 'package:badl_app/Components/future_builder.dart';
import 'package:badl_app/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Diagnosis/first_page.dart';
import 'Login/mobile_number_page.dart';
import 'network/shared_pereference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Local.initDatabase();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyCcjmtc6X279u8zr2NQqbNR3ixuYGmN-GI",
      //   appId: "1:435708067697:web:4a8a928961ff54467280d0",
      //   messagingSenderId: "435708067697",
      //   projectId: "badl-7d08e",
      // ),
      );
  // Local.setValue(value: null);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: ThemeData(
        primaryColor: Style.nearlyDarkBlue.withOpacity(0.87),
        textTheme: Style.textTheme,
      ),
      home: CustomFutureBuilder<bool>(
        onSuccessWidget: (value) {
          if (value) {
            return FirstPage();
          } else {
            return LoginPage();
          }
        },
        futureFunction: Local.isLoggedIn(),
      ),
    ),
  );
}

import 'package:badl_app/network/network.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../style.dart';

class LoginController extends GetxController {
  int pageIndex = 0;
  final phoneNumber = TextEditingController();
  final otpNumber = TextEditingController();
  bool isOTPscreen = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  ConfirmationResult? confirmationResult;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String thisVerificationId = '';
  String name = '';
  String designation = '';
  String address = '';
  String Mail_iD = '';
  String phone_number = '';

  dynamic snacker(
          {String title = '',
          Function? onPressed,
          String buttonText = 'Close'}) =>
      SnackBar(
        action: SnackBarAction(
          label: buttonText,
          onPressed: () {
            // Code to execute.
            if (onPressed != null) {
              onPressed();
            }
            ScaffoldMessenger.of(scaffoldKey.currentContext!).clearSnackBars();
          },
        ),
        content: Text(
          title,
          style: Style.caption,
        ),
        duration: const Duration(milliseconds: 1000),
        width: Get.width / 1.10, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );

  void authe() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }

  bool get isPhoneNumberValid => ((phoneNumber.text.length == 10) &&
      (int.tryParse(phoneNumber.text) != null));

  void snackBar(String message) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!)
        .showSnackBar(snacker(title: message));
  }

  Future<dynamic> authenticateUser() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${phoneNumber.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        snackBar('Verification Successful');
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          snackBar('The provided phone number is not valid.');
        } else
          snackBar('Verification Failed! Retry');
        print(e.code);
      },
      codeSent: (String verificationId, int? resendToken) async {
        snackBar('OTP has been sent!!!');
        isOTPscreen = true;
        thisVerificationId = verificationId;
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        snackBar('Time Out');
      },
    );
  }

  Future<bool?> verifyOTP() async {
    final authCredential = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: thisVerificationId,
        smsCode: otpNumber.text,
      ),
    );
    print('Additional user info');
    print(authCredential.additionalUserInfo);
    print('Auth Credential User');
    print(authCredential.user!.phoneNumber);
    print(authCredential.user!.uid);
    print('Auth Credential');
    print(authCredential.credential);
    return finishSetup(authCredential);
  }

  Future<dynamic> webAuth() async {
    confirmationResult =
        await auth.signInWithPhoneNumber('+91${phoneNumber.text}');
    isOTPscreen = true;
    update();
  }

  Future<bool?> verifyOtpWeb() async {
    UserCredential userCredential =
        await confirmationResult!.confirm(otpNumber.text);
    print(userCredential);
    print('The details are obtained');
    return finishSetup(userCredential);
  }

  Future<bool?> finishSetup(UserCredential userCredential) async {
    try {
      if (userCredential.user != null) {
        //SHOW SCAFFOLD
        // I/flutter (11956): Additional user info
        // I/flutter (11956): AdditionalUserInfo(isNewUser: true, profile: {}, providerId: null, username: null)
        // I/flutter (11956): Auth Credential User
        // I/flutter (11956): +919585447986
        // I/flutter (11956): 2LigMbbxz2S0NfgUmXoxlMwEtXX2
        // I/flutter (11956): Auth Credential
        // I/flutter (11956): null
        // Reloaded 1 of 1002 libraries in 2,191ms.
        print(userCredential.additionalUserInfo!.isNewUser);
        if (userCredential.additionalUserInfo!.isNewUser) {
          return true;
        } else {
          return false;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future setUID(bool isNewUser) async {
    if (auth.currentUser != null) {
      await Local.setValue(value: auth.currentUser!.uid);
      await Local.setUserName(value: auth.currentUser!.displayName!);
      if (isNewUser)
        Local.setDesignation(value: designation);
      else
        await Network.getUserInfo(uid: auth.currentUser!.uid).then(
          (value) async {
            await Local.setDesignation(value: value.Designation);
          },
        );
    }
  }
}

class Validator {
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return null;
    }
    return "Enter valid Email";
  }

  static String? number(String number) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (number.length != 0) {
      return 'Please enter valid mobile number';
    } else if (!regExp.hasMatch(number)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? isEmpty(String? text) {
    if (text == null || text.isEmpty) {
      return 'This field cannot be empty';
    }
    text.replaceAll(" ", "");
    if (text == "") {
      return "Enter Value";
    }
    return null;
  }

  static String? password(String text) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(text)) {
      return null;
    }
    return "Enter strong password EX: Vignesh123!";
  }
}

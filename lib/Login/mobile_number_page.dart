import 'package:animate_do/animate_do.dart';
import 'package:badl_app/diagnosis/bouncing_widget.dart';
import 'package:badl_app/diagnosis/first_page.dart';
import 'package:badl_app/login/login_controller.dart';
import 'package:badl_app/login/user_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../style.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(LoginController()),
      builder: (LoginController controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const BADLWelcomeWidget(),
                    BadlMobileCard(
                      widgetList: [
                        Text(
                          (!controller.isOTPscreen)
                              ? 'Phone Number'
                              : 'OTP Number',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                        ),
                        FadeInDown(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: (!controller.isOTPscreen)
                                  ? controller.phoneNumber
                                  : controller.otpNumber,
                              cursorColor: Style.nearlyDarkBlue,
                              textAlign: (controller.isOTPscreen)
                                  ? TextAlign.center
                                  : TextAlign.left,
                              style: thisFieldStyle().copyWith(
                                color: Colors.blue.shade900,
                              ),
                              decoration: thisFieldDecoration().copyWith(
                                prefix: Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Text(
                                    (controller.isOTPscreen) ? '' : '(+91)',
                                    style: Style.button.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Style.nearlyDarkBlue
                                          .withOpacity(0.32),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        BouncingButton(
                          voidCallback: () async {
                            if (!controller.isOTPscreen) {
                              if (controller.isPhoneNumberValid) {
                                Style.loadingDialog(
                                    controller.scaffoldKey.currentContext!,
                                    title: 'Please wait...');
                                if (!kIsWeb)
                                  await controller.authenticateUser();
                                else
                                  await controller.webAuth();
                                Navigator.pop(
                                    controller.scaffoldKey.currentContext!);
                              } else {
                                Navigator.pop(
                                    controller.scaffoldKey.currentContext!);
                                controller.snackBar(
                                  'Please enter a valid phone number',
                                );
                              }
                            } else if (controller.isOTPscreen) {
                              if (controller.otpNumber.text.isNotEmpty) {
                                Style.loadingDialog(
                                    controller.scaffoldKey.currentContext!,
                                    title: 'Please wait...');
                                bool? isNewUser;
                                if (!kIsWeb) {
                                  isNewUser = await controller.verifyOTP();
                                } else {
                                  isNewUser = await controller.verifyOtpWeb();
                                }
                                Navigator.pop(
                                    controller.scaffoldKey.currentContext!);
                                if (isNewUser != null) {
                                  if (isNewUser) {
                                    Style.navigate(context, UserInfoPage());
                                  } else {
                                    await controller.setUID(false);
                                    Style.navigate(context, FirstPage());
                                  }
                                } else if (isNewUser == null) {
                                  controller.snackBar(
                                    'Authentication failed. Please try again',
                                  );
                                }
                              } else {
                                controller.snackBar(
                                  'Please enter a valid OTP',
                                );
                              }
                            }
                          },
                          title: 'Proceed',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextStyle thisFieldStyle() {
    return Style.subtitle2.copyWith(
      fontSize: 17,
      color: Colors.blueGrey.shade700,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w600,
    );
  }

  InputDecoration thisFieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Style.nearlyDarkBlue.withOpacity(0.048),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black12,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Style.nearlyDarkBlue.withOpacity(0.60),
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class BadlMobileCard extends StatelessWidget {
  final List<Widget> widgetList;
  const BadlMobileCard({
    Key? key,
    required this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: Get.width / 14, vertical: 8),
      elevation: 10,
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        ),
      ),
    );
  }
}

class BADLWelcomeWidget extends StatelessWidget {
  const BADLWelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Lottie.asset(
          'assets/Json/welcome.json',
          height: MediaQuery.of(context).size.height / 3.6,
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  bottom: 1,
                ),
                child: Text(
                  'BADL Index App',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.80),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  'Digital Assessment Platform',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

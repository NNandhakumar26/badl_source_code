import 'package:badl_app/diagnosis/bouncing_widget.dart';
import 'package:badl_app/diagnosis/first_page.dart';
import 'package:badl_app/Login/login_controller.dart';
import 'package:badl_app/modals/user.dart';
import 'package:badl_app/network/network.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../style.dart';

class UserInfoPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (LoginController controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    DecorationWidget(),
                    thisPageTextField(
                      title: 'Name',
                      values: (value) {
                        controller.name = value;
                      },
                      icon: Icons.person_rounded,
                      validator: (value) => Validator.isEmpty(controller.name),
                    ),
                    thisPageTextField(
                      title: 'Designation',
                      values: (value) {
                        controller.designation = value;
                      },
                      icon: Icons.account_tree_rounded,
                      validator: (value) =>
                          Validator.isEmpty(controller.designation),
                    ),
                    thisPageTextField(
                      title: 'Work Address',
                      values: (value) {
                        controller.address = value;
                        print(controller.address);
                      },
                      icon: Icons.location_history_rounded,
                      maxLines: 4,
                      validator: (value) => null,
                    ),
                    thisPageTextField(
                      title: 'Mail ID',
                      values: (value) {
                        controller.Mail_iD = value;
                      },
                      icon: Icons.email_rounded,
                      validator: (value) => Validator.email(controller.Mail_iD),
                    ),
                    thisPageTextField(
                      title: 'Contact Number',
                      readOnly: true,
                      values: (value) {
                        controller.phone_number = value;
                      },
                      icon: Icons.phone_in_talk_rounded,
                      initialValue: controller.phoneNumber.text,
                      validator: (value) => null,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: BouncingButton(
                        voidCallback: () async {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.auth.currentUser != null) {
                              Style.loadingDialog(context,
                                  title: 'Almost Done');
                              await controller.auth.currentUser!
                                  .updateDisplayName(controller.name);
                              await controller.auth.currentUser!
                                  .updateEmail(controller.Mail_iD);
                              controller.auth.currentUser!.uid;

                              Network.createUser(
                                User(
                                  Name: controller.name,
                                  uid: controller.auth.currentUser!.uid,
                                  Mail: controller.Mail_iD,
                                  Contact: controller.phoneNumber.text,
                                  Designation: controller.designation,
                                  Address: controller.address,
                                ),
                              ).then(
                                (value) async {
                                  Navigator.pop(context);
                                  await controller.setUID(true);
                                  Get.offAll(() => FirstPage());
                                },
                              );
                            }
                          }
                        },
                        title: 'Update',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Padding thisPageTextField({
    String? initialValue,
    String? title,
    required Function values,
    IconData? icon,
    int? maxLines,
    bool readOnly = false,
    //validator function
    required String? Function(String? value) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: TextFormField(
        initialValue: initialValue ?? '',
        onChanged: (value) {
          values(value);
        },
        cursorColor: Style.nearlyDarkBlue,
        style: thisFieldStyle().copyWith(
          color: Colors.blue.shade900,
        ),
        readOnly: readOnly,
        maxLines: maxLines ?? 1,
        validator: (value) => validator(value),
        decoration: thisFieldDecoration(
          title: title,
        ).copyWith(
          prefixIcon: Icon(
            icon,
            size: 18,
            color: Style.nearlyDarkBlue.withOpacity(0.40),
          ),
        ),
      ),
    );
  }

  TextStyle thisFieldStyle() {
    return Style.subtitle2.copyWith(
      fontSize: 16,
      color: Colors.blueGrey.shade700,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w600,
    );
  }

  InputDecoration thisFieldDecoration({
    String? title,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Style.nearlyDarkBlue.withOpacity(0.048),
      labelText: title ?? '',
      labelStyle: Style.caption.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black38,
        // color: Style.nearlyDarkBlue.withOpacity(0.60),
      ),
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

class DecorationWidget extends StatelessWidget {
  const DecorationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Text(
            'Your Info',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
          ),
        ),
        Opacity(
          opacity: 0.3,
          child: Lottie.asset(
            'assets/Json/doctor.json',
            height: 200, width: 200, animate: true,
            // height: MediaQuery.of(context).size.height / 8,
            // width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}

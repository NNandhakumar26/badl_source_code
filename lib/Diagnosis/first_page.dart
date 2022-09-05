import 'package:badl_app/diagnosis/question_controller.dart';
import 'package:animate_do/animate_do.dart';
import 'package:badl_app/modals/patientInfo.dart';
import 'package:badl_app/diagnosis/main_page.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../style.dart';
import 'bouncing_widget.dart';

class FirstPage extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (QuestionController controller) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  backgroundWidget(context),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: Text(
                                  "BADL Index",
                                  style: Style.headline5.copyWith(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 24,
                                ),
                                child: Text(
                                  'Signed in as, ${FirebaseAuth.instance.currentUser?.displayName ?? 'User'}',
                                  style: Style.subtitle1.copyWith(
                                    // fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),

                              FadeInDown(
                                delay: Duration(milliseconds: 300),
                                duration: Duration(milliseconds: 500),
                                child: firstPageContainer(
                                  title: 'Age',
                                  inputType: TextInputType.number,
                                  onChanged: (String text) {
                                    if (int.tryParse(text) != null) {
                                      controller.patientDetails.age =
                                          int.parse(text);
                                      if ((int.parse(text) <= 5) &&
                                          (int.parse(text) > 0)) {
                                        controller.lessThan5 = true;
                                        controller.update();
                                      } else {
                                        controller.lessThan5 = false;
                                        controller.update();
                                      }
                                    }
                                  },
                                ),
                              ),

                              if (controller.lessThan5)
                                BounceInDown(
                                  delay: Duration(milliseconds: 100),
                                  duration: Duration(milliseconds: 500),
                                  child: firstPageContainer(
                                    title: 'Months',
                                    inputType: TextInputType.number,
                                    onChanged: (String text) {
                                      if (int.tryParse(text) != null) {
                                        controller.patientDetails.months =
                                            int.parse(text);
                                        // controller.otpValue = text;
                                      }
                                    },
                                  ),
                                ),
                              FadeInDown(
                                delay: Duration(milliseconds: 400),
                                duration: Duration(milliseconds: 500),
                                child: firstPageContainer(
                                  title: 'Gender',
                                  widget: DropdownButton<String>(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    value: (controller.gender == null)
                                        ? controller.gender = 'Male'
                                        : controller.gender,
                                    isExpanded: true,
                                    underline: Container(
                                      height: 0.4,
                                      color: Colors.blueGrey.shade600,
                                    ),
                                    items: ['Male', 'Female'].map(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Style.subtitle2.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.blueGrey.shade700,
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      controller.selectGender(value!);
                                    },
                                  ),
                                ),
                              ),

                              FadeInDown(
                                delay: Duration(milliseconds: 500),
                                duration: Duration(milliseconds: 500),
                                child: firstPageContainer(
                                  title: 'Diagnosis',
                                  inputType: TextInputType.text,
                                  onChanged: (String text) {
                                    controller.patientDetails.diagnosis = text;
                                    // if (int.tryParse(text) != null) {
                                    //   // controller.otpValue = text;
                                    // }
                                  },
                                ),
                              ),

                              FadeInDown(
                                delay: Duration(milliseconds: 600),
                                duration: Duration(milliseconds: 500),
                                child: firstPageContainer(
                                  title: 'Any Orthoses / Prostheses',
                                  widget: DropdownButton<String>(
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    value: (controller.selectOrthoses == null)
                                        ? 'No'
                                        : controller.selectOrthoses,
                                    isExpanded: true,
                                    underline: Container(
                                      height: 0.6,
                                      color: Colors.black54,
                                    ),
                                    items: ['Yes', 'No'].map(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: Style.subtitle2.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.blueGrey.shade700,
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      controller
                                          .selectOrthosesOrProtheses(value!);
                                    },
                                  ),
                                ),
                              ),

                              (controller.selectOrthoses == 'Yes')
                                  ? BounceInDown(
                                      delay: Duration(milliseconds: 100),
                                      duration: Duration(milliseconds: 500),
                                      child: firstPageContainer(
                                        title: 'Name Of the Device',
                                        onChanged: (String text) {
                                          controller.patientDetails
                                              .nameOfTheDevice = text;
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 22,
                              ),
                              //button
                              ElasticIn(
                                delay: Duration(milliseconds: 800),
                                duration: Duration(milliseconds: 800),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: BouncingButton(
                                    title: 'Continue',
                                    voidCallback: () async {
                                      controller.userInput.addAll(
                                        {
                                          "patientDetails": PatientDetails(
                                            age: controller.patientDetails.age,
                                            gender: controller.gender ?? 'Male',
                                            months: controller
                                                .patientDetails.months,
                                            anyOrthosesOrProstheses:
                                                controller.hasOrthoProsthesis,
                                            nameOfTheDevice: controller
                                                .patientDetails.nameOfTheDevice,
                                            diagnosis: controller
                                                .patientDetails.diagnosis,
                                          )
                                        },
                                      );

                                      controller.initialEliminationFunction(
                                        age: controller.patientDetails.age,
                                        isMale: controller.stringToIsMale(
                                          controller.gender ?? 'Male',
                                        ),
                                      );

                                      Style.navigateBack(
                                        context,
                                        QuestionPage(),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget backgroundWidget(BuildContext context) {
    return Positioned(
      child: Opacity(
        opacity: 0.04,
        child: Lottie.asset(
          'assets/Json/pad.json',
          height: MediaQuery.of(context).size.height / 1.6,
        ),
      ),
    );
  }
}

class firstPageContainer extends StatelessWidget {
  final String title;
  final Widget? widget;
  final TextInputType inputType;
  final Function? onChanged;
  const firstPageContainer({
    Key? key,
    required this.title,
    this.widget,
    this.inputType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      child: Row(
        children: [
          Expanded(flex: 7, child: rowLeftTitle(title: title)),
          Spacer(),
          Expanded(
            flex: 9,
            child: (widget == null)
                ? TextField(
                    cursorColor: Style.nearlyDarkBlue,
                    keyboardType: inputType,
                    onChanged: (String text) {
                      if (onChanged != null) {
                        onChanged!(text);
                      }
                    },
                    style: thisFieldStyle(),
                    decoration: thisFieldDecoration(),
                  )
                : widget!,
          ),
        ],
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

class rowLeftTitle extends StatelessWidget {
  final String title;
  rowLeftTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Text(
        title,
        style: Style.subtitle2.copyWith(
          fontSize: 15,
          color: Colors.blueGrey.shade600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

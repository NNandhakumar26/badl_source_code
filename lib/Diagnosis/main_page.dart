import 'package:animate_do/animate_do.dart';
import 'package:badl_app/components/company_appbar.dart';
import 'package:badl_app/components/custom_card.dart';
import 'package:badl_app/components/custom_dropdown.dart';
import 'package:badl_app/diagnosis/bouncing_widget.dart';
import 'package:badl_app/diagnosis/pdf_view_page.dart';
import 'package:badl_app/diagnosis/question_controller.dart';
import 'package:badl_app/modals/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style.dart';

class QuestionPage extends GetView<QuestionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      // Initialization is mandatory here...
      init: QuestionController(),
      builder: (QuestionController controller) {
        return DecoratedBox(
          decoration: Style.boxDecoration,
          child: Scaffold(
            key: controller.scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 64),
              child: CompanyAppBar(),
            ),
            body: SafeArea(
              child: Form(
                key: controller.formKey,
                // Column widget to keep the error's without vanishing on scroll
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FadeIn(
                        delay: Duration(milliseconds: 200),
                        // TODO: widget goes invisiblee
                        animate: true,
                        duration: Duration(milliseconds: 500),
                        child: CustomCardWidget(
                          widget: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  controller.displaySubTitle,
                                  textAlign: TextAlign.center,
                                  style: Style.headline6.copyWith(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...controller.displayComponents.map(
                                (Component component) {
                                  return ComponentWidget(
                                    e: component,
                                    controller: controller,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      ...controller.displaySubcomponents.map(
                        (SubComponent subcomponent) {
                          return CustomDropDown(
                            subcomponent,
                            (response) {
                              controller.updateSubcomponentResponse(
                                subcomponent,
                                response,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: bottomButton(controller),
          ),
        );
      },
    );
  }

  Widget bottomButton(QuestionController controller) {
    return ElasticIn(
      delay: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 800),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BouncingButton(
          voidCallback: () async {
            if (controller.formKey.currentState!.validate()) {
              // if (true) {
              controller.updateResponse().then(
                (value) {
                  if (value) {
                    controller.resetData();
                    controller.calculateFinalScoring();
                    Get.off(
                      PDFViewPage(
                        userInput: controller.userInput,
                      ),
                    );
                  }
                },
              );
            }
          },
          title: 'Update',
        ),
      ),
    );
  }
}

class ComponentWidget extends StatelessWidget {
  final Component? e;
  final QuestionController? controller;

  ComponentWidget({this.e, this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      duration: Duration(milliseconds: 500),
      decoration: decoration(),
      child: CheckboxListTile(
        value: e!.isChecked,
        onChanged: (value) {
          e!.isChecked = value ?? false;
          controller!.updateDisplaySubcomponents();
          // controller!.updateSubComp();
          controller!.update();
          // controller!.loadSubComponents(e!, value!);
        },
        activeColor: Style.nearlyDarkBlue,
        title: Text(
          e!.value!,
          style: Style.bodyText1.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Style.lightText,
            // color: Colors.blueGrey.shade700,
          ),
        ),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: e!.isChecked
              ? Style.nearlyDarkBlue.withOpacity(0.60)
              : Colors.blueGrey.withOpacity(0.10),
          width: 1.6,
        ),
        boxShadow: [
          e!.isChecked
              ? BoxShadow(
                  color: Style.nearlyDarkBlue.withOpacity(0.18),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                )
              : BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(0, 3),
                  blurRadius: 10,
                )
        ]);
  }
}

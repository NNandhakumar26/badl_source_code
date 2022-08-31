// import 'package:animate_do/animate_do.dart';
// import 'package:badl_app/Chat/chat_screen.dart';
// import 'package:badl_app/Diagnosis/bouncing_widget.dart';
// import 'package:badl_app/Diagnosis/pdf_view_page.dart';
// import 'package:badl_app/Diagnosis/question_controller.dart';
// import 'package:badl_app/modals/preference.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../style.dart';

// class QuestionPage extends GetView<QuestionController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<QuestionController>(
//       init: QuestionController(),
//       builder: (QuestionController controller) {
//         return DecoratedBox(
//           decoration: Style.boxDecoration,
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             appBar: PreferredSize(
//               preferredSize: Size(double.infinity, 64),
//               child: CompanyAppBar(),
//             ),
//             body: SafeArea(
//               child: Form(
//                 key: controller.formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       FadeIn(
//                         delay: Duration(milliseconds: 200),
//                         duration: Duration(milliseconds: 500),
//                         child: CustomCardWidget(
//                           widget: Column(
//                             children: [
//                               //TODO: Including the heading from preference heading...
//                               Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 8),
//                                 child: Text(
//                                   controller.currentPreference!.question ?? '',
//                                   textAlign: TextAlign.center,
//                                   style: Style.headline6.copyWith(
//                                     // color: Colors.blueGrey.shade400,
//                                     fontSize: 18,
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),

//                               ...controller.currentPreference!.components!.map(
//                                 (Component e) {
//                                   return ComponentWidget(
//                                     e: e,
//                                     controller: controller,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       //CHECK THIS

//                       ...controller.currentPreference!.subComponents!.map(
//                         (SubComponent subcomponent) {
//                           for (var id in controller.subComponentIDs) {
//                             if (subcomponent.ids!.contains(id)) {
//                               return CustomDropDown(
//                                 subcomponent,
//                                 (string) {
//                                   controller.updateSubComponents(
//                                       subcomponent, string);
//                                 },
//                               );
//                             }
//                           }
//                           return SizedBox();
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             bottomNavigationBar: bottomButton(controller),
//           ),
//         );
//       },
//     );
//   }

//   ElasticIn bottomButton(QuestionController controller) {
//     return ElasticIn(
//       delay: Duration(milliseconds: 400),
//       duration: Duration(milliseconds: 800),
//       child: Container(
//         height: 64,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: BouncingButton(
//           voidCallback: () {
//             if (controller.formKey.currentState!.validate()) {
//               bool temp = controller.updateHeadingCounter();
//               if (temp) {
//                 var tempr = controller.userInput;
//                 controller.refershData();
//                 Get.offAll(
//                   PDFViewPage(
//                     userInput: tempr,
//                   ),
//                 );
//               }
//             }
//           },
//           title: 'Update',
//         ),
//       ),
//     );
//   }
// }

// class CustomCardWidget extends StatelessWidget {
//   final Widget widget;
//   const CustomCardWidget({
//     Key? key,
//     required this.widget,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         elevation: 8,
//         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 12,
//             horizontal: 4,
//           ),
//           child: widget,
//         ),
//       ),
//     );
//   }
// }

// class CompanyAppBar extends StatelessWidget {
//   CompanyAppBar({
//     Key? key,
//   }) : super(key: key);
//   final QuestionController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: SizedBox(),
//       shadowColor: Style.nearlyDarkBlue.withOpacity(0.30),
//       backgroundColor: Style.nearlyDarkBlue.withOpacity(0.60),
//       elevation: 0,
//       leadingWidth: 0,
//       centerTitle: false,
//       actions: [
//         IconButton(
//           onPressed: () {
//             Get.to(ChatScreen());
//           },
//           icon: Icon(
//             Icons.contact_support_rounded,
//             size: 26,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(
//           width: 8,
//         )
//       ],
//       title: Text(
//         controller.question ?? '',
//         style: Style.headline6.copyWith(
//           // color: Style.nearlyDarkBlue.withOpacity(0.87),
//           color: Colors.white,
//           letterSpacing: 0.8,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// class ComponentWidget extends StatelessWidget {
//   final Component? e;
//   final QuestionController? controller;

//   ComponentWidget({this.e, this.controller, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//       margin: EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 8,
//       ),
//       duration: Duration(milliseconds: 500),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: e!.isChecked
//                 ? Style.nearlyDarkBlue.withOpacity(0.60)
//                 : Colors.blueGrey.withOpacity(0.10),
//             width: 1.6,
//           ),
//           boxShadow: [
//             e!.isChecked
//                 ? BoxShadow(
//                     color: Style.nearlyDarkBlue.withOpacity(0.18),
//                     offset: Offset(0, 3),
//                     blurRadius: 10,
//                   )
//                 : BoxShadow(
//                     color: Colors.grey.shade200,
//                     offset: Offset(0, 3),
//                     blurRadius: 10,
//                   )
//           ]),
//       child: CheckboxListTile(
//         value: e!.isChecked,
//         onChanged: (value) {
//           controller!.loadSubComponents(e!, value!);
//         },
//         activeColor: Style.nearlyDarkBlue,
//         title: Text(
//           e!.value!,
//           style: Style.bodyText1.copyWith(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Style.lightText,
//             // color: Colors.blueGrey.shade700,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomDropDown extends StatefulWidget {
//   final SubComponent subComponent;
//   final voidCallBack;

//   CustomDropDown(
//     this.subComponent,
//     this.voidCallBack,
//   );

//   @override
//   State<CustomDropDown> createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   final itemsList = [
//     'Dependent',
//     'Needs Assistance',
//     'Independent',
//     'Not Applicable'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(2),
//       ),
//       margin: EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 4,
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Text(
//                 widget.subComponent.value!,
//                 style: Style.caption.copyWith(
//                   fontSize: 14,
//                   letterSpacing: 0.0,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.blueGrey.shade600,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 6,
//             ),
//             Expanded(
//               flex: 3,
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 3,
//                 ),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     // color: Colors.blueGrey.shade600,
//                     color: Style.nearlyDarkBlue.withOpacity(0.8),
//                     width: 0.32,
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   iconEnabledColor: Style.nearlyDarkBlue.withOpacity(0.87),
//                   style: Style.overline.copyWith(
//                     letterSpacing: 0.2,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: Style.nearlyDarkBlue,
//                   ),
//                   hint: Text(
//                     'Select',
//                     softWrap: false,
//                     overflow: TextOverflow.ellipsis,
//                     style: Style.overline.copyWith(
//                       // letterSpacing: 0.2,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Style.nearlyDarkBlue.withOpacity(0.32),
//                     ),
//                   ),
//                   elevation: 20,
//                   value: widget.subComponent.response,
//                   isExpanded: true,
//                   validator: (value) => value == null ? 'Cannot Be Null' : null,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                   items: itemsList.map(
//                     (String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           overflow: TextOverflow.fade,
//                           softWrap: false,
//                           // style: Style.caption,
//                         ),
//                       );
//                     },
//                   ).toList(),
//                   onChanged: widget.voidCallBack,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

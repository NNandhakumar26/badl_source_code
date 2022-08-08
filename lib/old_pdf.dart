// import 'package:badl_app/Modals/patientInfo.dart';
// import 'package:badl_app/Modals/preference.dart';
// import 'package:badl_app/Modals/question_set.dart';
// import 'package:badl_app/style.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'dart:html' as html;

// import 'package:pdf/widgets.dart';

// class PdfPage {
//   static var anchor;

//   final Map<String, dynamic> data;
//   PdfPage({
//     required this.data,
//   });

//   static Future<dynamic> generate(Map<String, dynamic> data) async {
//     final pdf = Document();
//     pdf.addPage(
//       MultiPage(
//         build: (context) {
//           return [
//             Text('Hello'),
//             Wrap(children: [
//               Text('One'),
//               Text('Two'),
//               Text('Three'),
//             ]),
//           ];
//         },
//         pageTheme: pw.PageTheme(
//             pageFormat: PdfPageFormat(width, height)
//             theme: pw.ThemeData()),
//       ),
//     );
//     pdf.addPage(
//       pw.MultiPage(
//           build: (context) => [
//                 pw.Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     color: PdfColors.red),
//                 pw.Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     color: PdfColors.pink),
//               ]
//           // build: (context) => [
//           //   pw.Container(
//           //     // height: Get.height,
//           //     // width: Get.width,
//           //     height: double.infinity,
//           //     width: double.infinity,
//           //     color: PdfColors.amber100,
//           //     child: pw.Text('text'),
//           //   ),
//           //   // Container(
//           //   //   height: Get.height,
//           //   //   width: Get.width,
//           //   //   margin: EdgeInsets.all(16),
//           //   //   padding: EdgeInsets.all(2),
//           //   //   color: PdfColors.blueGrey700,
//           //   //   child: Container(
//           //   //     padding: EdgeInsets.all(16),
//           //   //     color: PdfColors.white,
//           //   //     child: Column(
//           //   //       children: [
//           //   //         buildTitle(),
//           //   //         // Divider(),
//           //   //         // buildPatiendInfo(data['patientDetails']),
//           //   //         // Divider(),
//           //   //         // ...data.entries.map(
//           //   //         //   (entry) {
//           //   //         //     if (entry.value.runtimeType == QuestionSet) {
//           //   //         //       Scoring scoring = entry.value.heading!.scoring!;
//           //   //         //       print(
//           //   //         //           'The scoring total is ${scoring.total} with dependent ${scoring.dependent},${scoring.independent},${scoring.partiallyDependent}');

//           //   //         //       return Column(
//           //   //         //         children: [
//           //   //         //           Container(
//           //   //         //             width: Get.width,
//           //   //         //             decoration: BoxDecoration(
//           //   //         //               color: PdfColors.blueGrey700,
//           //   //         //               borderRadius: BorderRadius.circular(4),
//           //   //         //             ),
//           //   //         //             margin: EdgeInsets.symmetric(vertical: 8),
//           //   //         //             padding: EdgeInsets.symmetric(vertical: 8),
//           //   //         //             child: Text(
//           //   //         //               entry.value.heading?.question ?? '',
//           //   //         //               // 'as',
//           //   //         //               textAlign: TextAlign.center,
//           //   //         //               // style: Style.headline6.copyWith(
//           //   //         //               //   decoration: TextDecoration.underline,
//           //   //         //               //   // color: Colors.black,
//           //   //         //               //   color: Colors.white,
//           //   //         //               //   letterSpacing: 0.8,
//           //   //         //               //   fontWeight: FontWeight.bold,
//           //   //         //               // ),
//           //   //         //             ),
//           //   //         //           ),
//           //   //         //           ...entry.value.preferences!.map(
//           //   //         //             (e) {
//           //   //         //               return buildPreference(e);
//           //   //         //             },
//           //   //         //           ).toList(),
//           //   //         //           buildScores(
//           //   //         //             scoring: scoring,
//           //   //         //             length: subComponentLength(entry.value),
//           //   //         //             total: scoring.total ?? 0,
//           //   //         //           ),
//           //   //         //         ],
//           //   //         //       );
//           //   //         //     }

//           //   //         //     return SizedBox();
//           //   //         //   },
//           //   //         // ),
//           //   //         // SizedBox(height: 3),
//           //   //         // buildSignature(),
//           //   //       ],
//           //   //     ),
//           //   //   ),
//           //   // ),
//           // ],

//           // footer: (context) => buildFooter(),
//           ),
//     );

//     savePDF(pdf, data);
//     return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }

//   static savePDF(Document pdf, thisbill) async {
//     Uint8List pdfInBytes = await pdf.save();
//     final blob = html.Blob([pdfInBytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     anchor = html.document.createElement('a') as html.AnchorElement
//       ..href = url
//       ..style.display = 'none'
//       ..download = 'pdf.pdf';
//     html.document.body!.children.add(anchor);
//     final bytes = await pdf.save();
//     final blob = html.Blob([bytes], 'application/pdf');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement()
//       ..href = url
//       ..style.display = 'none'
//       ..download = 'Report_Patient';
//     html.document.body?.children.add(anchor);
//     anchor.click();
//     html.document.body?.children.remove(anchor);
//     html.Url.revokeObjectUrl(url);
//   }

//   static final date = DateTime.now();
//   static final dueDate = date.add(Duration(days: 7));

//   static Widget buildTitle() => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 32,
//               ),
//               child: Image(
//                 image: AssetImage('assets/images/Logo.jpg'),
//                 height: 64,
//                 width: 64,
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'Dexterity Occupational Therapy',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 1.6,
//                 ),
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: Text(
//                     'Detailed Occupational-Therapy Evaluation Report',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 0.8),
//               ],
//             ),
//           ],
//         ),
//       );

 


 

//   static Widget buildTotal() {
//     final netTotal = invoice.items
//         .map((item) => item.unitPrice * item.quantity)
//         .reduce((item1, item2) => item1 + item2);
//     final vatPercent = invoice.items.first.vat;
//     final vat = netTotal * vatPercent;
//     final total = netTotal + vat;

//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildText(
//                   title: 'Net total',
//                   value: netTotal.toString(),
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'Vat ${vatPercent * 100} %',
//                   value: vat.toString(),
//                   unite: true,
//                 ),
//                 Divider(),
//                 buildText(
//                   title: 'Total amount due',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: total.toString(),
//                   unite: true,
//                 ),
//                 SizedBox(height: 2),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildFooter() => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2),
//           buildText(
//             title: 'Address',
//             value: 'value',
//           ),
//           SizedBox(height: 1),
//           buildSimpleText(
//               title: 'Paypal', value: ' invoice.supplier.paymentInfo'),
//         ],
//       );

//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(
//       fontWeight: FontWeight.bold,
//     );

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2),
//         Text(value),
//       ],
//     );
//   }

//   static buildPatiendInfo(PatientDetails details) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24,
//         vertical: 8,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             children: [
//               buildText(
//                 title: 'Age',
//                 value: (details.months == null)
//                     ? '${details.age} Years'
//                     : '${details.age} Years and ${details.months} Months',
//                 width: 300,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               buildText(
//                 title: 'Gender',
//                 value: '${details.gender}',
//                 width: 300,
//               ),
//             ],
//           ),
//           SizedBox(
//             width: 120,
//           ),
//           Column(
//             children: [
//               buildText(
//                 title: 'Diagnosis',
//                 value: '${details.diagnosis}',
//                 width: 450,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               buildText(
//                 title: 'Any Orthoses / Prostheses',
//                 value: ((details.anyOrthosesOrProstheses) == true)
//                     ? 'Yes - (${details.nameOfTheDevice})'
//                     : 'No',
//                 width: 450,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       margin: EdgeInsets.all(4),
//       child: Row(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Text(title, style: style),
//                 Text(' : '),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: unite ? style : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildSignature(context) {
//     return Container(
//       // width: Get.width,
//       // color: Colors.black.withOpacity(0.02),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Container(
//                   height: 100,
//                   width: 120,
//                   margin: EdgeInsets.all(8),
//                   color: PdfColors.white,
//                 ),
//                 Text(
//                   'Dr. Benny A Daniel',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).defaultTextStyle.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//                 Text(
//                   'Occupational Therapist',
//                   style: Theme.of(context).defaultTextStyle.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     // color: Colors.black.withOpacity(0.60),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   static Widget buildPreference(context, Preference preference) {
//     if (preference.components == null) preference.components = [];
//     if (preference.subComponents == null) {
//       preference.subComponents = [];
//     }
//     int counter = 0;
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             // width: Get.width,
//             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//             child: Text(
//               preference.question ?? '',
//               textAlign: TextAlign.left,
//               style:  Theme.of(context).defaultTextStyle.copyWith(
//                 // decoration: TextDecoration.underline,
//                 color: PdfColors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Divider(),
//           ...preference.components!.map(
//             (e) {
//               return ComponentWidget(text: e.value ?? '');
//             },
//           ).toList(),
//           Divider(),
//           ...preference.subComponents!.map(
//             (e) {
//               counter++;
//               return SubComponentText(
//                 sNo: counter.toString(),
//                 text: e.value ?? '',
//                 status: e.response ?? 'Dependent',
//               );
//             },
//           ).toList(),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: Get.height,
//           width: Get.width,
//           margin: EdgeInsets.all(16),
//           padding: EdgeInsets.all(2),
//           color: Colors.black45,
//           child: Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.white,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   buildTitle(),
//                   Divider(),
//                   buildPatiendInfo(data['patientDetails']),
//                   Divider(),
//                   ...data.entries.map(
//                     (entry) {
//                       if (entry.value.runtimeType == QuestionSet) {
//                         Scoring scoring = entry.value.heading!.scoring!;
//                         print(
//                             'The scoring total is ${scoring.total} with dependent ${scoring.dependent},${scoring.independent},${scoring.partiallyDependent}');

//                         return Column(
//                           children: [
//                             Container(
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.8),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               margin: EdgeInsets.symmetric(vertical: 8),
//                               padding: EdgeInsets.symmetric(vertical: 8),
//                               child: Text(
//                                 entry.value.heading?.question ?? '',
//                                 // 'as',
//                                 textAlign: TextAlign.center,
//                                 style: Style.headline6.copyWith(
//                                   decoration: TextDecoration.underline,
//                                   // color: Colors.black,
//                                   color: Colors.white,
//                                   letterSpacing: 0.8,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             ...entry.value.preferences!.map(
//                               (e) {
//                                 return buildPreference(e);
//                               },
//                             ).toList(),
//                             buildScores(
//                               scoring: scoring,
//                               length: subComponentLength(entry.value),
//                               total: scoring.total ?? 0,
//                             ),
//                           ],
//                         );
//                       }

//                       return SizedBox();
//                     },
//                   ),
//                   // buildHeader(invoice),
//                   SizedBox(height: 3),
//                   //TODO:
//                   // buildInvoice(invoice),
//                   // circularProgressIndicator(),
//                   buildSignature(),
//                   // buildTotal(invoice),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   static double subComponentLength(QuestionSet questionSet) {
//     double value = 0;
//     questionSet.preferences!.map((e) => e.subComponents!.map((sub) => ++value));
//     for (var preference in questionSet.preferences!) {
//       for (var sub in preference.subComponents!) {
//         value++;
//       }
//     }
//     return value - questionSet.heading!.scoring!.notApplicable!.toDouble();
//   }
//     static double percentageCalculator({double value = 1, double length = 1}) {
//     print(value);
//     print('the length is $length');
//     print((value / length));
//     return value / length;
//   }

//   static Widget buildScores(
//       {Scoring? scoring, double length = 1, double total = 1}) {
//     double calculation() {
//       var dependent = percentageCalculator(
//         value: scoring?.dependent ?? 0,
//         length: length,
//       );
//       var partiallyDependent = percentageCalculator(
//         value: scoring?.partiallyDependent ?? 0,
//         length: length,
//       );

//       double temp = ((total * dependent) / 100) +
//           (((total * partiallyDependent) / 100) / 2);
//       return temp * 100;
//     }

//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//           color: PdfColors.black,
//           borderRadius: BorderRadius.circular(4),
//         ),
//         margin: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
//         padding: EdgeInsets.symmetric(
//           horizontal: 8,
//           vertical: 16,
//         ),
//         child: Column(
//           children: [
//             Container(
//               elevation: 10,
//               color: Colors.black.withOpacity(0.08),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: PdfColors.white,
//                 ),
//                 child: Text(
//                   'Total Score  :  ${calculation().toStringAsFixed(2)} / ${total}',
//                   style: Style.bodyText2.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 children: [
//                   linearProgressIndicator(
//                     value: percentageCalculator(
//                       value: scoring?.dependent ?? 0,
//                       length: length,
//                     ),
//                     text: 'Dependent',
//                   ),
//                   linearProgressIndicator(
//                     value: percentageCalculator(
//                       value: scoring?.partiallyDependent ?? 0,
//                       length: length,
//                     ),
//                     text: 'Partially Dependent',
//                   ),
//                   linearProgressIndicator(
//                     value: percentageCalculator(
//                       value: scoring?.independent ?? 0,
//                       length: length,
//                     ),
//                     text: 'Independent',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static Expanded linearProgressIndicator(
//       {double value = 0.6, String text = ''}) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.topCenter,
//         margin: EdgeInsets.only(top: 20),
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             Text(
//               '${((value * 100).toStringAsFixed(1))}% $text',
//               style: Style.bodyText2.copyWith(
//                 // fontSize: value * 100,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: LinearProgressIndicator(
//                 value: value,
//                 backgroundColor: PdfColors.grey300,
//                 valueColor: PdfColors.grey700,
//                 color: pdfcol,
//                 minHeight: ,
//                 minHeight: (value == 0) ? 2 : (value * 10),
//               ),
//             ),
//             Text('data')
//           ],
//         ),
//       ),
//     );
//   }



//   static Widget ComponentWidget({text}) {
//     final String text;
//     const ComponentWidget({
//       required this.text,
//     });

//     @override
//     Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: PdfColors.black.withOpacity(0.06),
//               color: PdfColors.black,
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             padding: EdgeInsets.all(4),
//             margin: EdgeInsets.only(right: 8),
//             child: Icon(
//               Icons.download_done_rounded,
//               color: PdfColors.black,
//               size: 14,
//             ),
//           ),
//           Text(
//             text,
//             style: Style.bodyText2.copyWith(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//     }
//   }

//   static Widget SubComponentText({sNo, text, status}) {
//     final String sNo;
//     final String text;
//     final String status;
//     const SubComponentText({
//       required this.sNo,
//       required this.text,
//       required this.status,
//     });

//     @override
//     Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           RichText(
//             softWrap: true,
//             overflow: TextOverflow.clip,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: '${sNo} . ',
//                   style: Style.subtitle2,
//                 ),
//                 TextSpan(
//                   text: text,
//                   style: Style.subtitle2.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 TextSpan(
//                   text: ' - ${status}',
//                   style: Style.subtitle2.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   }
// }

// class ComponentWidget {
//   final String text;
//   const ComponentWidget({
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               // color: PdfColors.black.withOpacity(0.06),
//               color: PdfColors.black,
//               // color: Colors.red,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             padding: EdgeInsets.all(4),
//             margin: EdgeInsets.only(right: 8),
//             // child: Icon(
//             //   Icons.download_done_rounded,
//             //   color: PdfColors.black,
//             //   size: 14,
//             // ),
//           ),
//           Text(
//             text,
//             // style: Style.bodyText2.copyWith(
//             //   fontSize: 16,
//             //   fontWeight: FontWeight.w600,
//             //   color: Colors.black87,
//             // ),
//           ),
//         ],
//       ),
//     );
//   // }
// }

// class SubComponentText extends StatelessWidget {
//   final String sNo;
//   final String text;
//   final String status;
//   const SubComponentText({
//     required this.sNo,
//     required this.text,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           RichText(
//             softWrap: true,
//             overflow: TextOverflow.ellipsis,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: '${sNo} . ',
//                   style: Style.subtitle2,
//                 ),
//                 TextSpan(
//                   text: text,
//                   style: Style.subtitle2.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 TextSpan(
//                   text: ' - ${status}',
//                   style: Style.subtitle2.copyWith(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

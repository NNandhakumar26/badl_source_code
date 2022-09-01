import 'package:badl_app/modals/patientInfo.dart';
import 'package:badl_app/modals/preference.dart';
import 'package:badl_app/modals/question_set.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor lightBlack = PdfColor.fromInt(0xff808080);
const PdfColor lightGrey = PdfColor.fromInt(0xffF0EFEF);
const sep = 120.0;

class PdfPage {
  Future<dynamic> generate(Map<String, dynamic> data) async {
    final doc = pw.Document(
      title: 'Badl Report',
      producer: 'BADL Index',
      author: 'Doctor Name',
    );
    print('passed 1');

    String name = await Local.getUserName();
    String designation = await Local.getDesignation();

    Future<pw.PageTheme> _myPageTheme() async {
      PdfPageFormat format = PdfPageFormat.a4;

      format = format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 0 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm,
      );
      return pw.PageTheme(
        pageFormat: format,
        theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.openSansRegular(),
          bold: await PdfGoogleFonts.openSansBold(),
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        buildBackground: (pw.Context context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              margin: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
              child: pw.Container(
                margin: const pw.EdgeInsets.all(5),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: lightBlack,
                    width: 3,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
                child: pw.Center(
                  child: pw.Transform.rotate(
                    angle: 45,
                    child: pw.Text(
                      'BADL Index',
                      textScaleFactor: 4.8,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            color: PdfColors.grey50,
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            fontItalic: pw.Font.helveticaBold(),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    final pageTheme = await _myPageTheme();

    doc.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    'BADL Index App',
                    textScaleFactor: 3,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Text(
                    'Digital Assessment Platform',
                    textScaleFactor: 1,
                    style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                          color: lightBlack,
                        ),
                  ),
                ],
              ),
              buildPatientInfo(details: data['patientDetails']),
              buildSignature(
                context,
                name: name,
                designation: designation,
              ),
            ],
          );
        },
      ),
    );

    for (var entry in data.entries) {
      if (entry.value.runtimeType == QuestionSet) {
        Scoring scoring = entry.value.heading!.scoring!;
        List<Preference> preferences = entry.value.preferences;
        doc.addPage(
          pw.Page(
            pageTheme: pageTheme,
            build: (context) => pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  margin: pw.EdgeInsets.symmetric(vertical: 24),
                  alignment: pw.Alignment.center,
                  child: _Category(
                    title: entry.value.heading?.question ?? '',
                  ),
                ),
                buildScores(
                  context,
                  scoring: scoring,
                  // length: subComponentLength(entry.value),
                  total: scoring.total ?? 0,
                  relativeScore: scoring.relativeScore,
                ),
              ],
            ),
          ),
        );
        doc.addPage(
          pw.MultiPage(
            pageTheme: pageTheme,
            header: (pw.Context context) {
              return pw.Container(
                width: double.infinity,
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'BADL Index App',
                      textScaleFactor: 0.87,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text('Digital Assessment Platform',
                        textScaleFactor: 0.6,
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                            .copyWith(color: PdfColors.grey700)),
                  ],
                ),
              );
              // return pw.Container(
              //     alignment: pw.Alignment.centerRight,
              //     margin:
              //         const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              //     padding:
              //         const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              //     decoration: const pw.BoxDecoration(
              //         border: pw.Border(
              //             bottom: pw.BorderSide(
              //                 width: 0.5, color: PdfColors.grey))),
              //     child: pw.Text('Portable Document Format',
              //         style: pw.Theme.of(context)
              //             .defaultTextStyle
              //             .copyWith(color: PdfColors.grey)));
            },
            footer: (pw.Context context) {
              return pw.Container(
                  alignment: pw.Alignment.centerRight,
                  margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                  child: pw.Text(
                      'Page ${context.pageNumber} of ${context.pagesCount}',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey)));
            },
            build: (context) => [
              ...preferences.map(
                (Preference e) {
                  return _buildPreference(context, e);
                },
              ).toList(),
            ],
          ),
        );
      }
    }

    print('Finidhed');
    return doc.save();
  }

  static pw.Container buildPatientInfo({PatientDetails? details}) {
    // details = PatientDetails(
    //     userID: 'userID',
    //     age: 3,
    //     months: 5,
    //     gender: "Male",
    //     anyOrthosesOrProstheses: true,
    //     nameOfTheDevice: 'Device',
    //     diagnosis: 'Thermometer');

    return pw.Container(
      color: PdfColors.grey300,
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      margin: pw.EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: pw.Column(
        children: [
          // pw.Center(
          //   child: pw.Text(
          //     'Demographic Data',
          //     textScaleFactor: 1.5,
          //   ),
          // ),
          // pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.SizedBox(width: 10),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  buildText(
                    title: 'Age',
                    value: (details?.months == null)
                        ? '${details!.age} Years'
                        : '${details!.age} Years, ${details.months} Months',
                    width: 180,
                  ),
                  pw.SizedBox(
                    height: 16,
                  ),
                  buildText(
                    title: 'Gender',
                    value: '${details.gender}',
                    width: 180,
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  buildText(
                    title: 'Diagnosis',
                    value: '${details.diagnosis}',
                    width: 340,
                  ),
                  pw.SizedBox(
                    height: 16,
                  ),
                  buildText(
                    title: 'Any Orthoses / Prostheses',
                    value: ((details.anyOrthosesOrProstheses) == true)
                        ? 'Yes - (${details.nameOfTheDevice})'
                        : 'No',
                    width: 340,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      padding: pw.EdgeInsets.all(6),
      child: pw.Row(
        children: [
          pw.Row(
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                  color: PdfColors.grey700,
                  letterSpacing: 0.16,
                ),
              ),
              pw.Text(' : '),
              pw.Text(
                value,
                overflow: pw.TextOverflow.clip,
                softWrap: false,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 15,
                    color: PdfColors.grey900,
                    letterSpacing: 0.3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static _buildPreference(context, Preference preference) {
    return pw.Column(
      children: <pw.Widget>[
        pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 16),
          child: pw.Text(
            preference.question ?? '',
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                ),
          ),
        ),
        (preference.components != null)
            ? pw.Column(
                children: [
                  ...preference.components!.map(
                    (e) {
                      return pw.Container(
                        margin: pw.EdgeInsets.symmetric(vertical: 4),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          '${preference.components!.indexOf(e) + 1} . ${e.value}',
                          softWrap: true,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                      );
                    },
                  ).toList()
                ],
              )
            : pw.SizedBox(),
        pw.SizedBox(height: 8),
        (preference.subComponents != null)
            ? pw.Wrap(
                children: [
                  ...preference.subComponents!.map(
                    (SubComponent s) {
                      return _Block(
                        content: s.value ?? '',
                        title: s.response ?? 'Dependent',
                      );
                    },
                  ).toList(),
                ],
              )
            : pw.SizedBox(),
      ],
    );
  }

  static componentWidget(context, {String text = ''}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            decoration: pw.BoxDecoration(
              color: lightBlack,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            padding: pw.EdgeInsets.all(4),
            margin: pw.EdgeInsets.only(right: 8),
            child: pw.Icon(
              pw.IconData(0xe5ca),
              color: PdfColors.white,
              size: 14,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              text,
              softWrap: true,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
          ),
          // pw.Text(
          //   text,
          //   style: Style.bodyText2.copyWith(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black87,
          //   ),
          // ),
        ],
      ),
    );
  }

  static buildScores(context,
      {scoring,
      double length = 1,
      double total = 0,
      required double relativeScore}) {
    // double calculation() {
    //   var dependent = percentageCalculator(
    //     value: scoring?.dependent ?? 0,
    //     length: length,
    //   );
    //   var partiallyDependent = percentageCalculator(
    //     value: scoring?.partiallyDependent ?? 0,
    //     length: length,
    //   );

    //   double temp = ((total * dependent) / 100) +
    //       (((total * partiallyDependent) / 100) / 2);
    //   return temp * 100;
    // }

    return pw.Center(
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColors.grey200,
          borderRadius: pw.BorderRadius.circular(4),
        ),
        margin: pw.EdgeInsets.symmetric(horizontal: 6),
        padding: pw.EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: pw.Column(
          children: [
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 64, vertical: 8),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(2),
                color: PdfColors.white,
              ),
              child: pw.Text(
                'Total Score  :  ${relativeScore.toStringAsFixed(2)} / ${total.toStringAsFixed(2)}',
                style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold,
                    ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Row(
                children: [
                  linearProgressIndicator(
                    context,
                    value: percentageCalculator(
                      value: scoring?.dependent ?? 0,
                      length: length,
                    ),
                    text: 'Dependent',
                  ),
                  linearProgressIndicator(
                    context,
                    value: percentageCalculator(
                      value: scoring?.partiallyDependent ?? 0,
                      length: length,
                    ),
                    text: 'Partially Dependent',
                  ),
                  linearProgressIndicator(
                    context,
                    value: percentageCalculator(
                      value: scoring?.independent ?? 0,
                      length: length,
                    ),
                    text: 'Independent',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static double subComponentLength(QuestionSet questionSet) {
    double value = 0;
    questionSet.preferences.map((e) => e.subComponents!.map((sub) => ++value));
    for (var preference in questionSet.preferences) {
      for (var sub in preference.subComponents!) {
        value++;
      }
    }
    // TODO: NOTE HEre
    return value;
    // return value - questionSet.heading!.scoring!.notApplicable!.toDouble();
  }

  static double percentageCalculator({int value = 1, double length = 1}) {
    return value / length;
  }

  static pw.Widget linearProgressIndicator(context,
      {double value = 0.6, String text = ''}) {
    return pw.Expanded(
      child: pw.Container(
        // width: double.infinity,
        alignment: pw.Alignment.topCenter,
        margin: pw.EdgeInsets.only(top: 20),
        padding: pw.EdgeInsets.symmetric(horizontal: 16),
        child: pw.Column(
          children: [
            pw.Text(
              '${((value * 100).toStringAsFixed(1))}% ',
              textScaleFactor: 1.24,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 8),
              child: pw.LinearProgressIndicator(
                value: value,
                backgroundColor: PdfColors.grey300,
                valueColor: PdfColors.grey700,
              ),
            ),
            pw.Text('$text')
          ],
        ),
      ),
    );
  }

  static pw.Widget buildSignature(context,
      {required String name, required String designation}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Spacer(),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
            children: [
              // pw.Container(
              //   height: 100,
              //   width: 120,
              //   margin: pw.EdgeInsets.all(8),
              //   color: PdfColors.white,
              // ),
              pw.Text(
                name,
                textAlign: pw.TextAlign.center,
                style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.4,
                    ),
              ),
              pw.SizedBox(
                height: 6,
              ),
              pw.Text(
                designation,
                style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                      color: lightBlack,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGrey,
        borderRadius: pw.BorderRadius.all(
          pw.Radius.circular(8),
        ),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: pw.Text(
        title.toUpperCase(),
        textScaleFactor: 3.2,
        style: pw.Theme.of(context).defaultTextStyle.copyWith(
              fontWeight: pw.FontWeight.bold,
              // fontSize: 12,
              color: PdfColors.grey900,
            ),
      ),
    );
  }
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    required this.content,
    // this.document
  });

  final String title;
  final String content;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 10,
            height: 10,
            margin: const pw.EdgeInsets.only(
              top: 3,
              right: 6,
            ),
            decoration: const pw.BoxDecoration(
              color: PdfColors.grey700,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Text(
            title,
            style: pw.Theme.of(context)
                .defaultTextStyle
                .copyWith(fontWeight: pw.FontWeight.bold),
          ),
          pw.Expanded(
            child: pw.Text(
              ' - $content',
            ),
          ),
        ],
      ),
    );
  }
}

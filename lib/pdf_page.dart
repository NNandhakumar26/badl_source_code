import 'package:badl_app/Modals/question.dart';
import 'package:badl_app/modals/question_set.dart';
import 'package:badl_app/modals/patientInfo.dart';
import 'package:badl_app/modals/preference.dart';
import 'package:badl_app/network/shared_pereference.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor lightBlack = PdfColor.fromInt(0xff808080);
const PdfColor lightGrey = PdfColor.fromInt(0xffF0EFEF);
const sep = 120.0;
List<Scoring> scoringList = [];

class PdfPage {
  Future<dynamic> generate(Map<String, dynamic> data) async {
    final doc = pw.Document(
      title: 'Badl Report',
      producer: 'BADL Index',
      author: 'Doctor Name',
    );
    print('passed 1');

    String? name = await Local.getUserName();
    String? designation = await Local.getDesignation();

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
              patientDetailsWidget(
                details: data['patientDetails'],
              ),
              pw.Column(
                children: [
                  masterScoringWidget(
                    context,
                    scoringListGenerator(
                      data,
                    ),
                  ),
                  pw.SizedBox(height: 24),
                  signatureWidget(
                    context,
                    name: name,
                    designation: designation,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    for (var entry in data.entries) {
      if (entry.value.runtimeType == QuestionSet) {
        Scoring scoring = (entry.value as QuestionSet).heading!.scoring!;
        // print('object');
        // print(scoring.dependentPercent);
        // print(scoring.independent);
        // print(scoring.partiallyDependent);
        // print('object');
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
                scoreWidget(
                  context,
                  scoring: scoring,
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
                    pw.Text(
                      'Digital Assessment Platform',
                      textScaleFactor: 0.6,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            color: PdfColors.grey700,
                          ),
                    ),
                  ],
                ),
              );
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

    print('Finished');
    return doc.save();
  }

  static List<Scoring> scoringListGenerator(Map value) {
    List<Scoring> returnValue = [];
    for (var questionset in value.entries) {
      if (questionset.key == 'patientDetails')
        continue;
      else
        returnValue.add((questionset.value as QuestionSet).heading!.scoring!);
    }
    return returnValue;
  }

  static pw.Container patientDetailsWidget({PatientDetails? details}) {
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
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.SizedBox(width: 16),
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              buildText(
                title: 'Age',
                value: (details?.months == null)
                    ? '${details!.age} Years'
                    : '${details!.age} Years, ${details.months} Months',
              ),
              pw.SizedBox(
                height: 8,
              ),
              buildText(
                title: 'Gender',
                value: '${details.gender}',
              ),
              pw.SizedBox(
                height: 8,
              ),
              buildText(
                title: 'Diagnosis',
                value: '${details.diagnosis}',
              ),
              pw.SizedBox(
                height: 8,
              ),
              buildText(
                title: 'Any Orthoses / Prostheses',
                value: ((details.anyOrthosesOrProstheses) == true)
                    ? 'Yes - (${details.nameOfTheDevice})'
                    : 'No',
              ),
            ],
          ),
          pw.SizedBox(width: 16),
        ],
      ),
    );
  }

  static pw.Widget buildText({
    required String title,
    required String value,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    return pw.Container(
      width: 400,
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

  static pw.Widget _buildPreference(context, Preference preference) {
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
                  ...preference.components!
                      .where((element) => element.isChecked)
                      .map(
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

  static scoreWidget(
    context, {
    required Scoring scoring,
    required double relativeScore,
  }) {
    return scoringLayout(
      [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(2),
            color: PdfColors.white,
          ),
          child: pw.Text(
            'Total Score  :  ${relativeScore.toStringAsFixed(2)} / ${scoring.total!.toStringAsFixed(2)}',
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
                value: scoring.dependentPercent,
                text: 'Dependent',
              ),
              linearProgressIndicator(
                context,
                value: scoring.partialPercent,
                text: 'Partially Dependent',
              ),
              linearProgressIndicator(
                context,
                value: scoring.independentPercent,
                text: 'Independent',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget masterScoringWidget(
      pw.Context context, List<Scoring> scoringList) {
    double percentCalculator(List<double> values) =>
        values.fold<double>(
            0.0, (previousValue, value) => previousValue + value) /
        (scoringList.length);

    double actualScore = scoringList.fold(0.0,
        (previousValue, scoring) => previousValue + (scoring.relativeScore));

    return scoringLayout(
      [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 64, vertical: 8),
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(2),
            color: PdfColors.white,
          ),
          child: pw.Text(
            'Total Score  :  ${actualScore.toStringAsFixed(2)} / 1',
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
                value: percentCalculator(
                    scoringList.map((e) => e.dependentPercent).toList()),
                text: 'Dependent',
              ),
              linearProgressIndicator(
                context,
                value: percentCalculator(
                    scoringList.map((e) => e.partialPercent).toList()),
                text: 'Partially Dependent',
              ),
              linearProgressIndicator(
                context,
                value: percentCalculator(
                    scoringList.map((e) => e.independentPercent).toList()),
                text: 'Independent',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget linearProgressIndicator(context,
      {double value = 0.0, String text = ''}) {
    return pw.Expanded(
      child: pw.Container(
        alignment: pw.Alignment.topCenter,
        margin: pw.EdgeInsets.only(top: 20),
        padding: pw.EdgeInsets.symmetric(horizontal: 16),
        child: pw.Column(
          children: [
            pw.Text(
              '${value.toStringAsFixed(2)}%',
              textScaleFactor: 1.24,
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 8),
              child: pw.LinearProgressIndicator(
                value: value / 100,
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

  static pw.Widget signatureWidget(context,
      {String? name, String? designation}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Spacer(),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
            children: [
              if (name != null)
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
              if (designation != null)
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

  static pw.Widget scoringLayout(List<pw.Widget> widgetList) {
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
          children: widgetList,
        ),
      ),
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

import 'dart:io';
import 'package:first_project/screens/pdf_create/new2_pdf_page.dart';
import 'package:first_project/screens/pdf_create/pt_home_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:printing/printing.dart';

class New2PdfCreateScreen extends StatefulWidget {
  const New2PdfCreateScreen({super.key});
  @override
  State<New2PdfCreateScreen> createState() => _New2PdfCreateScreenState();
}

class _New2PdfCreateScreenState extends State<New2PdfCreateScreen> {
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (_) => _createPdf(),
        canDebug: false,
        //allowPrinting: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowSharing: false,
        actions: [
          IconButton(
              onPressed: () async {
                Fluttertoast.showToast(msg: "Saving PDF");
                var dir = await getExternalStorageDirectory();
                File file = File("${dir!.path}/example.pdf");
                await file.writeAsBytes(await pdf.save());
                Fluttertoast.showToast(msg: "Download done!");
              },
              icon: const Icon(Icons.save)),
        ],
      ),
    );
  }

  Future<Uint8List> _createPdf() async {
    final size = MediaQuery.of(context).size;

    final List<pw.Widget> pdfPages = [];
    final pdfHeight = size.height * .95;
    final pdfWidth = size.width * .95;

    ///
    final availableHeight = pdfHeight - 20; // as padding to top & bottom (10)
    final availableWidth = pdfWidth - 20;
    const headerHeight = 230.0;
    final totalList = _setTotalList(availableWidth);
    // final availablePerPageWidgets = <pw.Widget>[];
    // int totalCreatedWidgets = 0;

    // ///
    // for (int i = 1; totalCreatedWidgets > totalList.length; i++) {
    //   availablePerPageWidgets.clear();
    //   // in firstPage there will be a header so first page's available must be compromised
    //   // for SecondPage there won't be a header so we don't need to subtract it from totalHeight
    //   final isFirstPage = i == 1 ? headerHeight : 0;
    //   final availableChildCount = ((availableHeight - isFirstPage) ~/ 42) - 1;
    //   totalCreatedWidgets += availableChildCount;
    //   for (int j = totalCreatedWidgets; j < availableChildCount; j++) {
    //     availablePerPageWidgets.add(totalList[j]);
    //   }
    //   pdfPages.add(
    //     await New2PdfPage().tryToCreateNew2Pdf(
    //       totalHeight: availableHeight,
    //       totalWidth: availableWidth,
    //       headerHeight: headerHeight,
    //       availableWidgets: availablePerPageWidgets,
    //       isFirstPage: i == 1,
    //     ),
    //   );
    //   break;
    //   //await Future.delayed(const Duration(milliseconds: 100));
    // }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat(pdfWidth, pdfHeight),
        build: (context) => [
          pw.SizedBox(
            width: pdfWidth,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(15),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    totalList.length,
                    (index) => pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: totalList[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return pdf.save();
  }

  pw.Widget _getTitleWidget(String title) {
    return pw.SizedBox(
      height: 38,
      child: pw.Text(
        title,
        style: pw.TextStyle(
            color: New2PdfRepo().skyPrimary, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _singleComplaint(PatChiefComplaint complaint, double width) {
    return pw.SizedBox(
      height: 38,
      width: width,
      child: New2PdfRepo().getLeftBodyText(complaint.symptom,
          '(for ${complaint.duration}) ${complaint.problem} ${complaint.comment}'),
    );
  }

  pw.Widget _singleFinding(PatChiefComplaint finding) {
    return pw.SizedBox(
      height: 38,
      child: New2PdfRepo().getLeftBodyText(finding.symptom,
          '(for ${finding.duration}) ${finding.problem} ${finding.comment}'),
    );
  }

  pw.Widget _singleMedicine(int i, PatMedicine medicine) {
    return pw.SizedBox(
      height: 45,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // medicine name
          pw.Text(
            '${i + 1}. ${medicine.medicineName}',
            style: pw.TextStyle(color: New2PdfRepo().bluePrimary, fontSize: 11),
          ),
          // scheduleTiming, foodGenre, duration
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              // scheduleTiming
              pw.Text(
                '~ ${medicine.shceduleTiming}',
                style:
                    pw.TextStyle(color: New2PdfRepo().textThird, fontSize: 8),
              ),
              // foodGenre
              pw.Text(
                '~ ${medicine.foodGenre}',
                style:
                    pw.TextStyle(color: New2PdfRepo().textThird, fontSize: 8),
              ),
              // duration
              pw.FittedBox(
                child: pw.Text(
                  '~ ${medicine.duration}',
                  style:
                      pw.TextStyle(color: New2PdfRepo().textThird, fontSize: 8),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 2),
          // note / comment
          pw.FittedBox(
            child: pw.Text(
              'Note:  ${medicine.comment}',
              maxLines: 2,
              overflow: pw.TextOverflow.clip,
              style: pw.TextStyle(color: New2PdfRepo().textThird, fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _singleDiagnosis(PatChiefComplaint diagnosis, double width) {
    return pw.SizedBox(
      height: 38,
      width: width,
      child: New2PdfRepo()
          .getLeftBodyText(diagnosis.symptom, ' ${diagnosis.comment}'),
    );
  }

  pw.Widget _singleFollowUP(DateTime date) {
    return pw.SizedBox(
      height: 38,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            "Follow Up",
            style: pw.TextStyle(
                color: New2PdfRepo().skyPrimary,
                fontWeight: pw.FontWeight.bold),
          ),
          New2PdfRepo().getRightBodyText('Date: ', date.toIso8601String(), ''),
        ],
      ),
    );
  }

  pw.Widget _singleAdvice(String advice) {
    return pw.SizedBox(
      height: 38,
      child: New2PdfRepo().getRightBodyText('', advice, 'med'),
    );
  }

  pw.Widget _singleHistory(PatChiefComplaint history) {
    return pw.SizedBox(
      height: 38,
      child: New2PdfRepo().getLeftBodyText(
        history.symptom,
        '(for ${history.duration}) ${history.problem} ${history.comment}',
      ),
    );
  }

  pw.Widget _getBlankSpace() => pw.SizedBox(height: 30);

  List<pw.Widget> _setTotalList(double width) {
    final totalList = <pw.Widget>[];
    final chiefComplains = [
      PatChiefComplaint(
        id: DateTime.now().add(const Duration(seconds: 1)).toIso8601String(),
        symptom: "Chest pain & excertain",
        duration: "5 days",
        problem: "Pain",
        comment: "irregular",
      ),
      PatChiefComplaint(
        id: DateTime.now().add(const Duration(seconds: 2)).toIso8601String(),
        symptom: "No Angina",
        duration: "10 days",
        problem: "",
        comment: "",
      ),
      PatChiefComplaint(
        id: DateTime.now().add(const Duration(seconds: 3)).toIso8601String(),
        symptom: "Tiredness",
        duration: "1 month",
        problem: "",
        comment: "Most of the time",
      ),
    ];
    final histories = [
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "CUD",
        duration: "5 days",
        problem: "Pain",
        comment: "irregular",
      ),
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "HID/CAD",
        duration: "10 days",
        problem: "",
        comment: "",
      ),
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "Cholesterol",
        duration: "1 month",
        problem: "",
        comment: "Most of the time",
      ),
    ];
    final diagnosis = [
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "Pop smear",
        duration: "",
        problem: "",
        comment: "Pain irregular",
      ),
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "Lumber puncture",
        duration: "",
        problem: "",
        comment: "",
      ),
    ];
    final findings = [
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "CBC",
        duration: "",
        problem: "",
        comment: "MCV 89.0",
      ),
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "Blood grouping",
        duration: "",
        problem: "",
        comment: "B positive",
      ),
      PatChiefComplaint(
        id: DateTime.now().toIso8601String(),
        symptom: "RBC Count",
        duration: "",
        problem: "",
        comment: "4.3-5.7 m",
      ),
    ];
    final medicineList = [
      PatMedicine(
        id: DateTime.now().toIso8601String(),
        medicineName: 'Tab. Pantonix 40mg',
        duration: '15 days',
        foodGenre: "Before food",
        shceduleTiming: "1-0-1",
        comment: 'Eat, if pain occurs',
      ),
      PatMedicine(
        id: DateTime.now().toIso8601String(),
        medicineName: 'Tab. Paranetamol',
        duration: '10 days',
        foodGenre: "After food",
        shceduleTiming: "0-0-1",
        comment: '',
      ),
      PatMedicine(
        id: DateTime.now().toIso8601String(),
        medicineName: 'Tab. Pantonix 40mg',
        duration: '2 months',
        foodGenre: "Before food",
        shceduleTiming: "1-1-1",
        comment: 'Call if emergency',
      ),
    ];
    final List<String> advices = [
      'You need to Praise first when u get up',
      'Brush ur teeth well',
      'Do the wdhu, do something that praises The ALMIGHTY',
      'Take a simple Breakfast, now get ass off the house',
      'Search for work or be relevant!',
    ];

    // chief Complaints
    totalList.add(_getTitleWidget("Chief Complaints"));
    for (int i = 0; i < chiefComplains.length; i++) {
      totalList.add(_singleComplaint(chiefComplains[i], width));
    }
    totalList.add(_getBlankSpace());
    // Findings
    totalList.add(_getTitleWidget("Findings / On Examination"));
    for (int i = 0; i < findings.length; i++) {
      totalList.add(_singleFinding(findings[i]));
    }
    totalList.add(_getBlankSpace());
    // Medicine
    totalList.add(_getTitleWidget("Medicine"));
    for (int i = 0; i < medicineList.length; i++) {
      totalList.add(_singleMedicine(i, medicineList[i]));
    }
    totalList.add(_getBlankSpace());
    // Diagnosis
    totalList.add(_getTitleWidget("Diagnosis"));
    for (int i = 0; i < diagnosis.length; i++) {
      totalList.add(_singleDiagnosis(diagnosis[i], width));
    }
    totalList.add(_getBlankSpace());
    // FollowUp date
    totalList.add(_singleFollowUP(DateTime.now()));
    totalList.add(_getBlankSpace());
    // Advices
    totalList.add(_getTitleWidget("Advice"));
    for (int i = 0; i < advices.length; i++) {
      totalList.add(_singleAdvice(advices[i]));
    }
    totalList.add(_getBlankSpace());
    // History
    totalList.add(_getTitleWidget("History"));
    for (int i = 0; i < histories.length; i++) {
      totalList.add(_singleHistory(histories[i]));
    }
    totalList.add(_getBlankSpace());
    return totalList;
  }
}

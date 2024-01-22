import 'package:first_project/screens/pdf_create/pt_home_offer_card.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PatCreatePDF {
  Future<pw.Widget> tryToCreatePdf({
    required double dividerHeight,
    required double leftPartWidth,
    required List<PatChiefComplaint> chiefComplaints,
    required List<PatChiefComplaint> historyList,
    required List<PatChiefComplaint> diagnosisList,
    required List<PatChiefComplaint> investigationList,
    required List<PatMedicine> medicineList,
    required List<String> advices,
    required int pageNumber,
  }) async {
    final image = await imageFromAssetBundle('assets/images/logo_extra1.png');

    return pw.Column(
      children: [
        pw.Text("textString"),
        // doctor info
        //pageNumber == 1 ? _getDocInfo(image) : pw.SizedBox(),
        //prescription Body
        // pw.Row(
        //   crossAxisAlignment: pw.CrossAxisAlignment.start,
        //   children: [
        // ///
        // // left part (Chief Complaints, history, diagnosis, investigation)
        // pw.Container(
        //   width: leftPartWidth,
        //   padding: const pw.EdgeInsets.all(10),
        //   child: pw.Column(
        //     crossAxisAlignment: pw.CrossAxisAlignment.start,
        //     children: [
        //       // Chief Complaints
        //       _getChiefComplaintsNnHistory(chiefComplaints, historyList),
        //       pw.SizedBox(height: 20),
        //       _getDiagnosisNnInvestigations(
        //           diagnosisList, investigationList),
        //     ],
        //   ),
        // ),
        // // divider
        // pw.SizedBox(
        //   width: .6,
        //   height: dividerHeight,
        //   child: pw.VerticalDivider(color: PdfColors.grey400),
        // ),

        // ///
        // // Right part (Medicine, FollowUp, Advice)
        // pw.Expanded(
        //  child:
        // pw.Padding(
        //   padding: const pw.EdgeInsets.all(10),
        //   child:
        // pw.ListView(
        //   //  crossAxisAlignment: pw.CrossAxisAlignment.start,
        //   children: [
        //     // Medicine List
        //     _getMedicineList(medicineList),
        //     pw.SizedBox(height: 20),
        //     // FollowUp Date
        //     // _getFollowUpNnAdvices(
        //     //     DateFormat.yMMMEd().format(DateTime.now()), advices),
        //   ],
        // ),
        // ),
        //       ),
        //     ],
        //   ),
      ],
    );
  }

  pw.Widget _getChiefComplaintsNnHistory(List<PatChiefComplaint> complaintList,
      List<PatChiefComplaint> historyList) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        PdfWidgets().getBodytTitle('Chief Complaints'),
        pw.SizedBox(height: 7),
        ...List.generate(
          complaintList.length,
          (i) => PdfWidgets().getLeftBodyText(complaintList[i].symptom,
              '(for ${complaintList[i].duration}) ${complaintList[i].problem} ${complaintList[i].comment}'),
        ),
        pw.SizedBox(height: 20),
        PdfWidgets().getBodytTitle('History'),
        pw.SizedBox(height: 7),
        ...List.generate(
          historyList.length,
          (i) => PdfWidgets().getLeftBodyText(
            historyList[i].symptom,
            '(for ${historyList[i].duration}) ${historyList[i].problem} ${historyList[i].comment}',
          ),
        ),
      ],
    );
  }

  pw.Widget _getDiagnosisNnInvestigations(List<PatChiefComplaint> diagnosisList,
      List<PatChiefComplaint> investigationList) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Diagnosis list
        PdfWidgets().getBodytTitle('Diagnosis'),
        pw.SizedBox(height: 5),
        ...List.generate(
          diagnosisList.length,
          (i) => PdfWidgets().getLeftBodyText(
              ' ${diagnosisList[i].symptom}', ' ${diagnosisList[i].comment}'),
        ),
        pw.SizedBox(height: 20),
        // Investigation List
        PdfWidgets().getBodytTitle('Investigation'),
        pw.SizedBox(height: 5),
        ...List.generate(
          investigationList.length,
          (i) => PdfWidgets().getLeftBodyText(
              ' ${investigationList[i].symptom}',
              ' ${investigationList[i].comment}'),
        ),
      ],
    );
  }

  pw.Widget _getMedicineList(List<PatMedicine> medicineList) {
    return pw.ListView(
      //crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        PdfWidgets().getBodytTitle('Medicine(Rx)'),
        pw.SizedBox(height: 7),
        ...List.generate(
          13,
          (i) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${i + 1}. ${medicineList[i % 3].medicineName}',
                  style: const pw.TextStyle(fontSize: 11),
                ),
                // scheduleTiming, foodGenre, duration
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    PdfWidgets().getRightBodyText(
                        '', ' ${medicineList[i % 3].shceduleTiming}', 'med'),
                    PdfWidgets().getRightBodyText(
                        '', ' ${medicineList[i % 3].foodGenre}', 'med'),
                    PdfWidgets().getRightBodyText(
                        '', ' ${medicineList[i % 3].duration}', 'med'),
                  ],
                ),
                pw.SizedBox(height: 2),
                // note / comment
                pw.Text(
                  'Note : medicineList[i%3].comment ',
                  style: const pw.TextStyle(color: PdfColors.grey600),
                ),
                pw.SizedBox(height: 8),
              ],
            );
          },
        ),
      ],
    );
  }

  pw.Widget _getFollowUpNnAdvices(String date, List<String> adviceList) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            PdfWidgets().getBodytTitle('Follow Up'),
            pw.Spacer(),
            PdfWidgets().getRightBodyText('Date: ', date, ''),
          ],
        ),
        // advice list
        pw.SizedBox(height: 20),
        PdfWidgets().getBodytTitle('Advice'),
        pw.SizedBox(height: 7),
        // advice list
        ...List.generate(
          4,
          (i) => pw.Padding(
            padding: const pw.EdgeInsets.only(left: 10, bottom: 3),
            child: PdfWidgets().getRightBodyText('', adviceList[i % 4], 'med'),
          ),
        ),
      ],
    );
  }

  pw.Widget _getDocInfo(pw.ImageProvider image) {
    return pw.Column(
      children: [
        pw.Stack(
          children: [
            pw.Positioned(
              right: 0,
              top: -20,
              bottom: 0,
              child: pw.Center(child: pw.Image(image, width: 100)),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Dr. Abduallah Al Jubayer',
                  style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfWidgets()._bluePrimary,
                      fontWeight: pw.FontWeight.bold),
                ),
                PdfWidgets().getDoctorCategory("General Medicine"),
                pw.SizedBox(height: 10),
                pw.Text('Dhaka Medical College & Hospital, Dhaka',
                    style: const pw.TextStyle(letterSpacing: 1)),
                PdfWidgets().getTopTitleText('Email', 'itisjubayer@gmail.com'),
                PdfWidgets()
                    .getTopTitleText('Cell', '01628430948, 01234567891'),
                pw.SizedBox(height: 5),
                PdfWidgets().getTopTitleText('BMDC', '24569877'),
                pw.SizedBox(height: 10),
                pw.Divider(thickness: .1, color: PdfColors.grey),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: PdfWidgets().getTopTitleText(
                          'Patient', 'Abu Bakar Siddique Talha'),
                    ),
                    pw.Column(
                      children: [
                        PdfWidgets().getTopTitleText('Age', '22'),
                        pw.SizedBox(height: 5),
                        PdfWidgets().getTopTitleText('Weight', '70kg'),
                      ],
                    ),
                  ],
                ),
                pw.Divider(thickness: .7, color: PdfColors.grey400),
              ],
            ),
          ],
        ),
        // patient name, age & weight
        pw.SizedBox(
          height: 15,
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child:
                PdfWidgets().getRightBodyText("Date", "${DateTime.now()}", ''),
          ),
        ),
      ],
    );
  }
}

class PdfWidgets {
  final _skyPrimary = const PdfColor.fromInt(0xFF30BCED);
  final _bluePrimary = const PdfColor.fromInt(0xFF01204E);
  final _blueSecondary = const PdfColor.fromInt(0xFF0E4D7B);
  final _textPrimary = const PdfColor.fromInt(0xFF000000);
  final _textThird = const PdfColor.fromInt(0xFF808080);

  pw.RichText getTopTitleText(String title, String subtitle) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$title : ',
            style: pw.TextStyle(color: _textThird),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: _textPrimary, letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  pw.Widget getBodytTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(color: _skyPrimary, fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget getRightBodyText(String title, String subtitle, String key) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: key.contains('med') ? '~$title : ' : '$title : ',
            style: pw.TextStyle(color: _textThird),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: _textPrimary),
          ),
        ],
      ),
    );
  }

  pw.Widget getLeftBodyText(String title, String subtitle) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '~ $title ',
            style: pw.TextStyle(color: _textPrimary),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: _textThird, fontSize: 10),
          ),
        ],
      ),
    );
  }

  pw.Widget getDoctorCategory(String title) => pw.Container(
        padding:
            const pw.EdgeInsets.only(left: 7, top: 3, bottom: 3, right: 14),
        //margin: const EdgeInsets.only(bottom: 5),
        decoration: pw.BoxDecoration(
          color: _blueSecondary,
          borderRadius: const pw.BorderRadius.horizontal(
            left: pw.Radius.circular(4),
            right: pw.Radius.circular(14),
          ),
        ),
        child: pw.Text(
          title,
          maxLines: 1,
          style: const pw.TextStyle(
              fontSize: 9, color: PdfColor.fromInt(0xFFFFFFFF)),
        ),
      );
}

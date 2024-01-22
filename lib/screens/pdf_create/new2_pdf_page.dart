import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'package:printing/printing.dart';

class New2PdfPage {
  double totalHeight = 0, totalWidth = 0;
  Future<pw.Widget> tryToCreateNew2Pdf({
    required double totalHeight,
    required double totalWidth,
    required double headerHeight,
    required List<pw.Widget> availableWidgets,
    required bool isFirstPage,
  }) async {
    //final image = await imageFromAssetBundle('assets/images/logo_extra1.png');
    totalHeight = this.totalHeight;
    totalWidth = this.totalWidth;
    final height = totalHeight * .95 - 20;
    final width = totalWidth * .95 - 20;

    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      height: height,
      width: width,
      child: pw.Column(
        children: [
          // header
          isFirstPage
              ? pw.SizedBox(
                  height: headerHeight, width: width, child: _getDocInfo())
              : pw.SizedBox(),
          // body
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: List.generate(
                availableWidgets.length,
                (index) => availableWidgets[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _getDocInfo() {
    return pw.Column(
      children: [
        pw.Text(
          'Dr. Abduallah Al Jubayer',
          style: pw.TextStyle(
              fontSize: 20,
              color: New2PdfRepo().bluePrimary,
              fontWeight: pw.FontWeight.bold),
        ),
        New2PdfRepo().getDoctorCategory("General Medicine"),
        pw.SizedBox(height: 10),
        pw.Text('Dhaka Medical College & Hospital, Dhaka',
            style: const pw.TextStyle(letterSpacing: 1)),
        New2PdfRepo().getTopTitleText('Email', 'itisjubayer@gmail.com'),
        New2PdfRepo().getTopTitleText('Cell', '01628430948, 01234567891'),
        pw.SizedBox(height: 5),
        New2PdfRepo().getTopTitleText('BMDC', '24569877'),
        pw.SizedBox(height: 10),
        pw.Divider(thickness: .1, color: PdfColors.grey300),
        pw.Row(
          children: [
            pw.Expanded(
              child: New2PdfRepo()
                  .getTopTitleText('Patient', 'Abu Bakar Siddique Talha'),
            ),
            pw.Column(
              children: [
                New2PdfRepo().getTopTitleText('Age', '22'),
                pw.SizedBox(height: 5),
                New2PdfRepo().getTopTitleText('Weight', '70kg'),
              ],
            ),
          ],
        ),
        pw.Divider(thickness: .7, color: PdfColors.grey400),
        pw.SizedBox(
          height: 15,
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child:
                New2PdfRepo().getRightBodyText("Date", "${DateTime.now()}", ''),
          ),
        ),
      ],
    );
  }
}

class New2PdfRepo {
  final skyPrimary = const PdfColor.fromInt(0xFF30BCED);
  final bluePrimary = const PdfColor.fromInt(0xFF01204E);
  final blueSecondary = const PdfColor.fromInt(0xFF0E4D7B);
  final textPrimary = const PdfColor.fromInt(0xFF000000);
  final textThird = const PdfColor.fromInt(0xFF808080);

  pw.RichText getTopTitleText(String title, String subtitle) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$title : ',
            style: pw.TextStyle(color: textThird),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: textPrimary, letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  pw.Widget getBodytTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(color: skyPrimary, fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget getRightBodyText(String title, String subtitle, String key) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: key.contains('med') ? '~$title ' : '$title : ',
            style: pw.TextStyle(color: textThird),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: textPrimary),
          ),
        ],
      ),
    );
  }

  pw.Widget getLeftBodyText(String title, String subtitle) {
    return pw.RichText(
      maxLines: 2,
      overflow: pw.TextOverflow.clip,
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '~ $title ',
            style: pw.TextStyle(color: textPrimary),
          ),
          pw.TextSpan(
            text: subtitle,
            style: pw.TextStyle(color: textThird, fontSize: 10),
          ),
        ],
      ),
    );
  }

  pw.Widget getDoctorCategory(String title) => pw.Container(
        padding:
            const pw.EdgeInsets.only(left: 7, top: 3, bottom: 3, right: 14),
        //margin:  EdgeInsets.only(bottom: 5),
        decoration: pw.BoxDecoration(
          color: blueSecondary,
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

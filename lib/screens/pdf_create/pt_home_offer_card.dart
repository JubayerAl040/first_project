import 'dart:typed_data';
import 'package:first_project/screens/pdf_create/pat_create_pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PtHomeOfferCard extends StatefulWidget {
  const PtHomeOfferCard({super.key});
  @override
  State<PtHomeOfferCard> createState() => _PtHomeOfferCardState();
}

class _PtHomeOfferCardState extends State<PtHomeOfferCard> {
  final _chiefComplains = [
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
  final _histories = [
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
  final _diagnosis = [
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
  final _investigations = [
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
  final _medicineList = [
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
  final List<String> _advices = [
    'You need to Praise first when u get up',
    'Brush ur teeth well',
    'Do the wdhu, do something that praises The ALMIGHTY',
    'Take a simple Breakfast, now get ass off the house',
    'Search for work or be relevant!',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PdfPreview(
        build: (_) => _createPdf(size),
        canDebug: false,
        allowPrinting: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        // allowSharing: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
        ],
      ),
    );
  }

  Future<Uint8List> _createPdf(Size size) async {
    final size = MediaQuery.of(context).size;
    final pdf = pw.Document();
    final getWidget1 = await PatCreatePDF().tryToCreatePdf(
      dividerHeight: size.height * .5,
      leftPartWidth: size.width * .4,
      chiefComplaints: _chiefComplains,
      historyList: _histories,
      diagnosisList: _diagnosis,
      investigationList: _investigations,
      medicineList: _medicineList,
      advices: _advices,
      pageNumber: 1,
    );
    final getWidget2 = await PatCreatePDF().tryToCreatePdf(
      dividerHeight: size.height * .7,
      leftPartWidth: size.width * .35,
      chiefComplaints: _chiefComplains,
      historyList: _histories,
      diagnosisList: _diagnosis,
      investigationList: _investigations,
      medicineList: _medicineList,
      advices: _advices,
      pageNumber: 2,
    );
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat(size.width * .9, size.height * .85),
        build: (context) => [
          getWidget1,
        ],
      ),
    );

    return pdf.save();
  }
}

class PatChiefComplaint {
  final String id;
  final String symptom;
  final String duration;
  final String problem;
  final String comment;
  const PatChiefComplaint({
    required this.id,
    required this.symptom,
    required this.duration,
    required this.problem,
    required this.comment,
  });
}

class PatMedicine {
  final String id;
  final String medicineName;
  final String duration;
  final String foodGenre;
  final String shceduleTiming;
  final String comment;
  PatMedicine({
    required this.id,
    required this.medicineName,
    required this.duration,
    required this.foodGenre,
    required this.shceduleTiming,
    required this.comment,
  });
}

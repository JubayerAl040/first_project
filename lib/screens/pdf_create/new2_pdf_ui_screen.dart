import 'package:first_project/screens/pdf_create/new2_pdf_create_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class New2PdfUiScreen extends StatefulWidget {
  const New2PdfUiScreen({super.key});
  @override
  State<New2PdfUiScreen> createState() => _New2PdfUiScreenState();
}

class _New2PdfUiScreenState extends State<New2PdfUiScreen> {
  final totalList = <Widget>[];
  bool _isAdded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _getBody()),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'butn1',
            onPressed: () => _setTotalList(),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'bun2',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const New2PdfCreateScreen()),
              );
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    final size = MediaQuery.of(context).size;
    final height = size.height * .95 - 20;
    final width = size.width * .95 - 20;
    const headerHeight = 230.0;
    // final bodyHeightForFirstPage = height - headerHeight;
    // final bodyHeightDefault = height;
    //  final image = await imageFromAssetBundle('assets/images/logo_extra1.png');
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      height: size.height * .95,
      width: size.width * .95,
      child: Column(
        children: [
          // header
          Container(
            height: headerHeight,
            width: width,
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Abduallah Al Jubayer',
                      style: TextStyle(
                          fontSize: 20,
                          color: PdfNew2UiWidgets()._bluePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                    PdfNew2UiWidgets().getDoctorCategory("General Medicine"),
                    const SizedBox(height: 10),
                    const Text('Dhaka Medical College & Hospital, Dhaka',
                        style: TextStyle(letterSpacing: 1)),
                    PdfNew2UiWidgets()
                        .getTopTitleText('Email', 'itisjubayer@gmail.com'),
                    PdfNew2UiWidgets()
                        .getTopTitleText('Cell', '01628430948, 01234567891'),
                    const SizedBox(height: 5),
                    PdfNew2UiWidgets().getTopTitleText('BMDC', '24569877'),
                    const SizedBox(height: 10),
                    const Divider(thickness: .1, color: Colors.grey),
                    Row(
                      children: [
                        Expanded(
                          child: PdfNew2UiWidgets().getTopTitleText(
                              'Patient', 'Abu Bakar Siddique Talha'),
                        ),
                        Column(
                          children: [
                            PdfNew2UiWidgets().getTopTitleText('Age', '22'),
                            const SizedBox(height: 5),
                            PdfNew2UiWidgets()
                                .getTopTitleText('Weight', '70kg'),
                          ],
                        ),
                      ],
                    ),
                    Divider(thickness: .7, color: Colors.grey[400]),
                  ],
                ),
                SizedBox(
                  height: 15,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PdfNew2UiWidgets()
                        .getRightBodyText("Date", "${DateTime.now()}", ''),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: !_isAdded
                ? const SizedBox()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: totalList.length,
                    itemBuilder: (context, i) => totalList[i],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _getTitleWidget(String title) {
    const skyPrimary = Color(0xFF30BCED);
    return SizedBox(
      height: 38,
      child: Text(
        title,
        style: const TextStyle(color: skyPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _singleComplaint(PatChiefComplaint complaint) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 38,
      width: size.width * .9 - 20,
      child: PdfNew2UiWidgets().getLeftBodyText(complaint.symptom,
          '(for ${complaint.duration}) ${complaint.problem} ${complaint.comment}'),
    );
  }

  Widget _singleFinding(PatChiefComplaint finding) {
    return SizedBox(
      height: 38,
      child: PdfNew2UiWidgets().getLeftBodyText(finding.symptom,
          '(for ${finding.duration}) ${finding.problem} ${finding.comment}'),
    );
  }

  Widget _singleMedicine(int i, PatMedicine medicine) {
    return SizedBox(
      height: 45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '${i + 1}. ${medicine.medicineName}',
              style: const TextStyle(color: Color(0xFF01204E), fontSize: 11),
            ),
          ),
          // scheduleTiming, foodGenre, duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '~ ${medicine.shceduleTiming}',
                style: const TextStyle(color: Color(0xFF808080), fontSize: 8),
              ),
              Text(
                '~ ${medicine.foodGenre}',
                style: const TextStyle(color: Color(0xFF808080), fontSize: 8),
              ),
              FittedBox(
                child: Text(
                  '~ ${medicine.duration}',
                  style: const TextStyle(color: Color(0xFF808080), fontSize: 8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),
          // note / comment
          Expanded(
            child: Text(
              'Note:  ${medicine.comment}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: const Color(0xFF808080), fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleDiagnosis(PatChiefComplaint diagnosis) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 38,
      width: size.width * .9 - 20,
      child: PdfNew2UiWidgets()
          .getLeftBodyText(diagnosis.symptom, ' ${diagnosis.comment}'),
    );
  }

  Widget _singleFollowUP(DateTime date) {
    return SizedBox(
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Follow Up",
            style: TextStyle(
                color: Color(0xFF30BCED), fontWeight: FontWeight.bold),
          ),
          PdfNew2UiWidgets()
              .getRightBodyText('Date: ', date.toIso8601String(), ''),
        ],
      ),
    );
  }

  Widget _singleAdvice(String advice) {
    return SizedBox(
      height: 38,
      child: PdfNew2UiWidgets().getRightBodyText('', advice, 'med'),
    );
  }

  Widget _singleHistory(PatChiefComplaint history) {
    return SizedBox(
      height: 38,
      child: PdfNew2UiWidgets().getLeftBodyText(
        history.symptom,
        '(for ${history.duration}) ${history.problem} ${history.comment}',
      ),
    );
  }

  Widget _getBlankSpace() => const SizedBox(height: 38);

  void _setTotalList() {
    totalList.clear();
    Logger().d('Entering');
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
      totalList.add(_singleComplaint(chiefComplains[i]));
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
      totalList.add(_singleDiagnosis(diagnosis[i]));
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
    Logger().e('Total Length: ${totalList.length}');
    _isAdded = true;
    setState(() {});
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

class PdfNew2UiWidgets {
  final _skyPrimary = const Color(0xFF30BCED);
  final _bluePrimary = const Color(0xFF01204E);
  final _blueSecondary = const Color(0xFF0E4D7B);
  final _textPrimary = const Color(0xFF000000);
  final _textThird = const Color(0xFF808080);

  RichText getTopTitleText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title : ',
            style: TextStyle(color: _textThird),
          ),
          TextSpan(
            text: subtitle,
            style: TextStyle(color: _textPrimary, letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget getBodytTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: _skyPrimary, fontWeight: FontWeight.bold),
    );
  }

  Widget getRightBodyText(String title, String subtitle, String key) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: key.contains('med') ? '~$title ' : '$title : ',
            style: TextStyle(color: _textThird),
          ),
          TextSpan(
            text: subtitle,
            style: TextStyle(color: _textPrimary),
          ),
        ],
      ),
    );
  }

  Widget getLeftBodyText(String title, String subtitle) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.fade,
      text: TextSpan(
        children: [
          TextSpan(
            text: '~ $title ',
            style: TextStyle(color: _textPrimary),
          ),
          TextSpan(
            text: subtitle,
            style: TextStyle(color: _textThird, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget getDoctorCategory(String title) => Container(
        padding: const EdgeInsets.only(left: 7, top: 3, bottom: 3, right: 14),
        //margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: _blueSecondary,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(4),
            right: Radius.circular(14),
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          style: const TextStyle(fontSize: 9, color: Color(0xFFFFFFFF)),
        ),
      );
}

import 'package:first_project/screens/pdf_create/pt_home_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});
  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  static const _url =
      "https://agora-video-call-eight.vercel.app/?username=JbPatient&aptCode=123456Abc&c=patient";
  bool _isZoomEnable = true;
  final List<Widget> _pages = [];
  final int _selectedPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPage());
    super.initState();
  }

  void _addPage() => setState(() {
        _pages.add(PageCount(selectedPage: _selectedPage + 1));
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _pages.isEmpty ? const SizedBox() : _pages[_selectedPage],
          _isZoomEnable
              ? Positioned.fill(child: _showVideoCall())
              : Positioned(
                  top: MediaQuery.of(context).padding.top + 5,
                  right: 5,
                  width: 180,
                  height: 150,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _showVideoCall(),
                  )),
          // Positioned(
          //   bottom: 5,
          //   left: size.width * .2,
          //   width: size.width * .6,
          //   child: Container(
          //     height: 60,
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.all(5),
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF01204E),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: Row(
          //               children: List.generate(
          //                 _pages.length,
          //                 (i) => GestureDetector(
          //                   onTap: () {
          //                     setState(() => _selectedPage = i);
          //                     print('_selectedPage: $_selectedPage');
          //                   },
          //                   child: Container(
          //                     width: 40,
          //                     height: double.infinity,
          //                     padding: const EdgeInsets.all(5),
          //                     margin:
          //                         const EdgeInsets.symmetric(horizontal: 5),
          //                     alignment: Alignment.center,
          //                     decoration: BoxDecoration(
          //                       color: _selectedPage == i
          //                           ? Colors.amber
          //                           : Colors.white,
          //                       borderRadius: BorderRadius.circular(7),
          //                     ),
          //                     child: Text('P ${i + 1}'),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           width: 40,
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: IconButton(
          //             onPressed: () {
          //               _addPage();
          //             },
          //             icon: const Icon(Icons.add),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (_) => const PtHomeOfferCard()));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _showVideoCall() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned.fill(
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(_url)),
            initialSettings: InAppWebViewSettings(
              allowFileAccess: true,
              allowContentAccess: true,
              databaseEnabled: true,
              domStorageEnabled: true,
              allowBackgroundAudioPlaying: true,
              allowsInlineMediaPlayback: true,
              disallowOverScroll: true,
              mediaPlaybackRequiresUserGesture: false,
              iframeAllow: "camera; microphone",
              iframeAllowFullscreen: true,
              preferredContentMode: UserPreferredContentMode.MOBILE,
            ),
            onWebViewCreated: (cntrl) async => webViewController = cntrl,
            // onPermissionRequest: (controller, permissionRequest) async {
            //   return PermissionResponse(
            //     action: PermissionResponseAction.GRANT,
            //     resources: [
            //       PermissionResourceType.CAMERA,
            //       PermissionResourceType.MICROPHONE,
            //       PermissionResourceType.DEVICE_ORIENTATION_AND_MOTION,
            //       PermissionResourceType.MIDI_SYSEX,
            //       PermissionResourceType.PROTECTED_MEDIA_ID,
            //     ],
            //   );
            // },
            androidOnPermissionRequest: (controller, request, s) async {
              return PermissionRequestResponse(
                resources: s,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
            onNavigationResponse: (_, __) async =>
                NavigationResponseAction.ALLOW,
          ),
        ),
        Positioned(
          top: _isZoomEnable ? MediaQuery.of(context).padding.top + 5 : 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              backgroundColor: Colors.black,
            ),
            child:
                const Icon(Icons.close_outlined, size: 11, color: Colors.white),
          ),
        ),
        Positioned(
          top: _isZoomEnable ? MediaQuery.of(context).padding.top + 5 : 0,
          left: 0,
          child: ElevatedButton(
            onPressed: () => setState(() => _isZoomEnable = !_isZoomEnable),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(2),
              backgroundColor: Colors.black,
            ),
            child: Icon(
                _isZoomEnable ? Icons.minimize : Icons.home_max_outlined,
                size: 11,
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    webViewController!.dispose();
    super.dispose();
  }
}

class PageCount extends StatelessWidget {
  const PageCount({super.key, required this.selectedPage});
  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final date = DateFormat('MMM d,  h:mm a').format(DateTime.now());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // doctor info & soowGood-img
            const PrDocBookPrsDocInfo(),
            // date
            SizedBox(
              height: 15,
              child: Align(
                alignment: Alignment.centerRight,
                child: PatPrescriptionRepo()
                    .getTitleText("Page:$selectedPage Date", date, context),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // chief , history, diagnosis, investigation
                SizedBox(
                  width: size.width * .32,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // chief complaints & History
                      PrDocBookPrsChiefCompHistory(),
                      SizedBox(height: 20),
                      // diagnosis & investigation
                      PrDocBookPrsDiagnosInvestigate(),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                // divider
                SizedBox(
                  width: 4,
                  height: size.height * .6,
                  child: const VerticalDivider(color: Colors.black26),
                ),

                const SizedBox(width: 15),
                // medicine, advice, follow-up
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrDocBookPrsMedicine(),
                      SizedBox(height: 20),
                      PrDocBookPrsFollowUpAdvice(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrDocBookPrsChiefCompHistory extends StatefulWidget {
  const PrDocBookPrsChiefCompHistory({super.key});
  @override
  State<PrDocBookPrsChiefCompHistory> createState() =>
      _PrDocBookPrsChiefCompHistoryState();
}

class _PrDocBookPrsChiefCompHistoryState
    extends State<PrDocBookPrsChiefCompHistory> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // chief complaints title
        GestureDetector(
          onTap: () {},
          child: PatPrescriptionRepo()
              .getBodytTitle('Chief Complaints ✍', context),
        ),
        const SizedBox(height: 5),
        // chief complaints List
        ...List.generate(
          _chiefComplains.length,
          (i) => PatPrescriptionRepo().getBodySubtitle(
            '❏ ${_chiefComplains[i].symptom}',
            '(for ${_chiefComplains[i].duration}) ${_chiefComplains[i].problem} ${_chiefComplains[i].comment}',
            context,
          ),
        ),
        const SizedBox(height: 20),
        // History title
        GestureDetector(
          onTap: () {},
          child: PatPrescriptionRepo().getBodytTitle('History ✍', context),
        ),
        const SizedBox(height: 5),
        // History List
        ...List.generate(
          _histories.length,
          (i) => PatPrescriptionRepo().getBodySubtitle(
            '❏ ${_histories[i].symptom}',
            '(for ${_histories[i].duration}) ${_histories[i].problem} ${_histories[i].comment}',
            context,
          ),
        ),
      ],
    );
  }
}

class PrDocBookPrsDocInfo extends StatelessWidget {
  const PrDocBookPrsDocInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: -20,
          bottom: 0,
          width: 100,
          child: Center(
            child: Image.asset('assets/images/logo_extra1.png'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Abduallah Al Jubayer',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 7, top: 3, bottom: 3, right: 14),
              //margin: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                color: Color(0xFF0E4D7B),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(4),
                  right: Radius.circular(14),
                ),
              ),
              child: const Text(
                "General Medicine",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Text('Dhaka Medical College & Hospital, Dhaka',
                style: Theme.of(context).textTheme.bodyMedium!),
            PatPrescriptionRepo()
                .getTitleText('Email', 'itisjubayer@gmail.com', context),
            PatPrescriptionRepo()
                .getTitleText('Cell', '01628430948, 01234567891', context),
            const SizedBox(height: 5),
            PatPrescriptionRepo().getTitleText('BMDC', '24569877', context),
            const SizedBox(height: 10),
            const Divider(thickness: .5),
            Row(
              children: [
                Expanded(
                  child: PatPrescriptionRepo().getTitleText(
                      'Patient', "Abu Bakar Siddique Talha", context),
                ),
                Column(
                  children: [
                    PatPrescriptionRepo().getTitleText('Age', '22', context),
                    const SizedBox(height: 5),
                    PatPrescriptionRepo()
                        .getTitleText('Weight', '70kg', context),
                  ],
                ),
              ],
            ),
            const Divider(thickness: .7),
          ],
        ),
      ],
    );
  }
}

class PrDocBookPrsFollowUpAdvice extends StatefulWidget {
  const PrDocBookPrsFollowUpAdvice({super.key});
  @override
  State<PrDocBookPrsFollowUpAdvice> createState() =>
      _PrDocBookPrsFollowUpAdviceState();
}

class _PrDocBookPrsFollowUpAdviceState
    extends State<PrDocBookPrsFollowUpAdvice> {
  final List<String> _advices = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // follow-up title
            GestureDetector(
              onTap: () {},
              child:
                  PatPrescriptionRepo().getBodytTitle('Follow up ✍', context),
            ),
            const Spacer(),
            // follow-up date
            PatPrescriptionRepo().getBodySubtitle(
              '❏ Date: ',
              DateFormat.yMMMEd().format(DateTime.now()),
              context,
            )
          ],
        ),
        const SizedBox(height: 20),
        // advice title
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              PatPrescriptionRepo().getBodytTitle('Advice ✍', context),
              PatPrescriptionRepo()
                  .getBodySubtitle(' ', '*(maximum 4)', context),
            ],
          ),
        ),
        const SizedBox(height: 5),
        // advice list
        ...List.generate(
          _advices.length,
          (i) => Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 3),
            child: Text(
              '❏ ${_advices[i]}',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}

class PrDocBookPrsMedicine extends StatefulWidget {
  const PrDocBookPrsMedicine({super.key});
  @override
  State<PrDocBookPrsMedicine> createState() => _PrDocBookPrsMedicineState();
}

class _PrDocBookPrsMedicineState extends State<PrDocBookPrsMedicine> {
  final _medicineList = [
    PatMedicine(
      id: DateTime.now().toIso8601String(),
      medicineName: 'Tab. Pantonix 40mg',
      duration: '১৫ দিন',
      foodGenre: "খাবার আগে",
      shceduleTiming: "১-0-১",
      comment: 'ব্যাথা হলে খাবে',
    ),
    PatMedicine(
      id: DateTime.now().toIso8601String(),
      medicineName: 'Tab. Paranetamol',
      duration: '১০ দিন',
      foodGenre: "খাবার পরে",
      shceduleTiming: "0-0-১",
      comment: '',
    ),
    PatMedicine(
      id: DateTime.now().toIso8601String(),
      medicineName: 'Tab. Pantonix 40mg',
      duration: '২ মাস',
      foodGenre: "খাবার আগে",
      shceduleTiming: "১-১-১",
      comment: 'সমস্যা হলে দ্রুত জানাবে',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              PatPrescriptionRepo().getBodytTitle('Medicine(Rx) ✍', context),
              PatPrescriptionRepo()
                  .getBodySubtitle(' ', '*( maximum 6)', context),
            ],
          ),
        ),
        const SizedBox(height: 7),
        ...List.generate(
          _medicineList.length,
          (i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${i + 1}. ${_medicineList[i].medicineName}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 11),
                ),
                // scheduleTiming, foodGenre, duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PatPrescriptionRepo().getBodySubtitle(
                        '✔', ' ${_medicineList[i].shceduleTiming}', context),
                    PatPrescriptionRepo().getBodySubtitle(
                        '✔', ' ${_medicineList[i].foodGenre}', context),
                    PatPrescriptionRepo().getBodySubtitle(
                        '✔', ' ${_medicineList[i].duration}', context),
                  ],
                ),
                const SizedBox(height: 2),
                // note / comment
                Text(
                  'Note:  ${_medicineList[i].comment}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black38),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ],
    );
  }
}

class PrDocBookPrsDiagnosInvestigate extends StatefulWidget {
  const PrDocBookPrsDiagnosInvestigate({super.key});
  @override
  State<PrDocBookPrsDiagnosInvestigate> createState() =>
      _PrDocBookPrsBodyLeftState();
}

class _PrDocBookPrsBodyLeftState extends State<PrDocBookPrsDiagnosInvestigate> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Diagnosis title
        GestureDetector(
          onTap: () {},
          child: PatPrescriptionRepo().getBodytTitle('Diagnosis ✍', context),
        ),
        const SizedBox(height: 5),
        // Diagnosis list
        ...List.generate(
          _diagnosis.length,
          (i) => PatPrescriptionRepo().getBodySubtitle(
            '❏ ${_diagnosis[i].symptom}',
            ' ${_diagnosis[i].comment}',
            context,
          ),
        ),
        const SizedBox(height: 20),
        // Investigation title
        GestureDetector(
          onTap: () {},
          child:
              PatPrescriptionRepo().getBodytTitle('Investigation ✍', context),
        ),
        const SizedBox(height: 5),
        // Investigation List
        ...List.generate(
          _investigations.length,
          (i) => PatPrescriptionRepo().getBodySubtitle(
            '❏ ${_investigations[i].symptom}',
            ' ${_investigations[i].comment}',
            context,
          ),
        ),
      ],
    );
  }
}

class PatPrescriptionRepo {
  static const durationType = ['Hours', 'Days', 'Months', 'Year'];

  static const medicineTiming = [
    "1-0-0",
    "0-1-0",
    "0-0-1",
    "1-1-0",
    "1-0-1",
    "0-1-1",
    "1-1-1"
  ];

  static const foodGenre = ["Before Food", "After Food"];

  RichText getTitleText(String title, String subtitle, BuildContext ctx) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title : ',
            style: Theme.of(ctx)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black38),
          ),
          TextSpan(
            text: subtitle,
            style: Theme.of(ctx).textTheme.bodySmall!,
          ),
        ],
      ),
    );
  }

  Widget getBodytTitle(String title, BuildContext ctx) {
    return Text(
      title,
      style: Theme.of(ctx).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF30BCED),
          ),
    );
  }

  Widget getBodySubtitle(String title, String subtitle, BuildContext ctx) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title ',
            style: Theme.of(ctx).textTheme.bodySmall!.copyWith(fontSize: 10),
          ),
          TextSpan(
            text: subtitle,
            style: Theme.of(ctx)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

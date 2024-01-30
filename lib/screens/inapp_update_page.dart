import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class InAppUpdateScreen extends StatefulWidget {
  const InAppUpdateScreen({super.key});
  @override
  State<InAppUpdateScreen> createState() => _InAppUpdateScreenState();
}

class _InAppUpdateScreenState extends State<InAppUpdateScreen> {
  final List<int> _scheduleDates = [1, 3, 4, 6, 7];
  final _dateController = TextEditingController();

  bool _isDateHighlighted(DateTime date) {
    for (int i = 0; i < _scheduleDates.length; i++) {
      print('its coming here');
      if (_scheduleDates[i] == date.weekday) {
        return true;
      }
    }
    return false;
  }

  void _checkHeighLightDate() async {
    final currentDate = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 365)),
      selectableDayPredicate: _isDateHighlighted,
    );
    if (date == null) return;
    // user can't take todays appointment soo um getting remainingHour
    // extra -1, bcz tommorrows date works perfectly either accurate hour cz prb
    final todaysRemainingHour = 24 - (currentDate.hour) - 1;
    if (date.isBefore(currentDate.add(Duration(hours: todaysRemainingHour)))) {
      Fluttertoast.showToast(msg: "Sorry! This date isn't available");
      return;
    }
    print("Selected Date: $date");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('In App Review Example')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _checkHeighLightDate,
              child: const Text('Check Heighlight Date'),
            ),
            const SizedBox(height: 20),
            CmDateField(label: "Birth Date", controller: _dateController)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}

class CmDateField extends StatelessWidget {
  const CmDateField(
      {super.key,
      required this.label,
      required this.controller,
      this.firstDate,
      this.lastDate});
  final String label;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // color line
        Container(
          width: 0.4,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColor.bluePrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            textInputAction: TextInputAction.done,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(Icons.calendar_today_outlined),
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: firstDate ??
                    DateTime.now().subtract(const Duration(days: 70 * 365)),
                lastDate:
                    lastDate ?? DateTime.now().add(const Duration(days: 30)),
              );
              if (date == null) return;
              controller.text = (DateFormat.yMMMd().format(date));
            },
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class MyColor {
  static const categoryColor = [
    Color(0xFFFF3D00),
    Color(0xFF69F0AE),
    Color(0xFF673AB7),
  ];

  static const ashhLight = Color(0xFFECF6FF);
  static const bluePrimary = Color(0xFF01204E);
  static const blueSecondary = Color(0xFF0E4D7B);
  static const skyPrimary = Color(0xFF30BCED);
  static const skySecondary = Color(0xFFBDDDFC);
  static const statusColor = Color(0xFFFEF8C0);
  static const statusText = Color(0xFF795548);
  static const dividerColor = Color(0x42000000);
  static const activeStatusColor = Color(0xFF00FF00);

  static const textColor = Color(0xFF2D2C2D);
  static const textSecondary = Color(0xFFF9F9F9);
  static const textThird = Colors.black38;

  static const themeTealBlue = Color(0xFF01204E);
  static const themeSkyBlue = Color(0xFF30BCED);
  static const blackPurple = Color(0xFF2D2C2D);
  static const tealBlueLight = Color(0xFF526D94);
  static const tealBlueDark = Color(0xFF0E4D7B);
  static const tealBlueMedium = Color(0xFF527EA8);

  static const skyBlueLight = Color(0xFFBDDDFC);
  static const offWhite = Color(0xFFF9F9F9);
  static const hintColor = Color(0x8001204F);

  static const activeOtp = Color(0xFFFFFFFF);
  static const selectedOtp = Color(0xFFBDDDFC);
  static const inactiveOtp = Color(0x80939597); //#929292

  static const lightPink = Color(0xffffccd8); //#929292
  static const darkPink = Color(0xfff8a0b5); //#929292

  static const black05 = Color(0x0d0d0d0d); //#929292

  static const teal = Color(0xE6010712); //
  static const teal40 = Color(0xCC010712); //

  static const searchColor = Color(0x8001204F);
  static const searchBgColor = Color(0x1F767680);

  static const clinicBgColor = Color(0x1A2FBBED);

  static const black06 = Color(0x0f9c9999); //#929292

  static const lightGreenBlue = Color(0xFFBBEFDD);
  static const teal50 = Color(0x800D4D7A);

  static const redBrown = Color(0xF8A10517);

  static const redBrownLight = Color(0xB3A10517);

  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFE1E4EA),
    100: Color(0xFFB3BCCA),
    200: Color(0xFF8090A7),
    300: Color(0xFF4D6383),
    400: Color(0xFF274169),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF011C47),
    700: Color(0xFF01183D),
    800: Color(0xFF011335),
    900: Color(0xFF000B25),
  });
  static const int _primaryPrimaryValue = 0xFF01204E;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFF607CFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFF002BF9),
    700: Color(0xFF0027E0),
  });
  static const int _primaryAccentValue = 0xFF2D52FF;
}

import 'package:first_project/screens/book_lawyer_screen.dart';
import 'package:first_project/screens/book_photograph_screen.dart';
import 'package:first_project/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InAppUpdateScreen extends StatefulWidget {
  const InAppUpdateScreen({super.key});
  @override
  State<InAppUpdateScreen> createState() => _InAppUpdateScreenState();
}

class _InAppUpdateScreenState extends State<InAppUpdateScreen> {
  final List<int> _scheduleDates = [1, 3, 4, 6, 7];
  final _dateController = TextEditingController();
  final _clockController = TextEditingController();

  bool _isDateHighlighted(DateTime date) {
    for (int i = 0; i < _scheduleDates.length; i++) {
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
    return PopScope(
      onPopInvoked: (_) async => await showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('In App Review Example')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()));
                },
                child: const Text('Go To Welcome Screen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BookPhotographScreen()));
                },
                child: const Text('BookPhotographScreen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const BookLawyerScreen()));
                },
                child: const Text('BookLawyerScreen'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkHeighLightDate,
                child: const Text('Check Heighlight Date'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _clockController.dispose();
    super.dispose();
  }
}

Future<bool> showExitPopup(BuildContext context) async => await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Exit App',
          style: TextStyle(
              fontFamily: "poppins_regular", fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Do you want to exit SoowGood?',
          style: TextStyle(
              fontFamily: "poppins_regular",
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyColor.bluePrimary),
            ),
            child: const Text(
              'No',
              style: TextStyle(color: MyColor.ashhLight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColor.bluePrimary),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: MyColor.ashhLight),
              ),
            ),
          ),
        ],
      ),
    );

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

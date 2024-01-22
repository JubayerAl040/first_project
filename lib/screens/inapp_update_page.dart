import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InAppUpdateScreen extends StatefulWidget {
  const InAppUpdateScreen({super.key});
  @override
  State<InAppUpdateScreen> createState() => _InAppUpdateScreenState();
}

class _InAppUpdateScreenState extends State<InAppUpdateScreen> {
  final List<int> _scheduleDates = [1, 3, 4, 6, 7];

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
    return MaterialApp(
      title: 'In App Review Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('In App Review Example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _checkHeighLightDate,
              child: const Text('Check Heighlight Date'),
            ),
          ],
        ),
      ),
    );
  }
}

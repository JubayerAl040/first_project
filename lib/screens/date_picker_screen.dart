import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);
  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  List<DateTime?> _dialogCalendarPickerValue = [
    // DateTime(2021, 8, 10),
    // DateTime(2021, 8, 13),
    DateTime.now(),
    DateTime.now().add(const Duration(days: 4)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DatePicker Screen")),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: [
              _buildCalendarDialogButton(),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                            timePickerTheme: TimePickerThemeData(
                          //elevation: 10,
                          backgroundColor: Colors.white, // Background color

                          hourMinuteTextColor:
                              Colors.black, // Text color for hours and minutes
                          // dayPeriodTextColor:
                          //     Colors.green[900], // Text color for AM/PM
                          dayPeriodBorderSide: const BorderSide(
                              color: Colors.white), // Border color for AM/PM
                          dialHandColor: Colors.black, // Color of the hour hand
                          // dialTextColor:
                          //     Colors.green, // Text color on the clock dial
                          dialBackgroundColor: Colors.white,
                          dayPeriodColor: Colors.white,
                          dayPeriodTextColor: Colors.black,
                          hourMinuteColor: Colors.grey[100],

                          // entryModeIconColor: Colors.blue,
                          // helpTextStyle: const TextStyle(
                          //   color: Colors
                          //       .blueAccent, // Set the text color for "Enter time"
                          // ),
                          //   cancelButtonStyle: ButtonStyle(
                          //       backgroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.brown.shade300),
                          //       foregroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.green[900]!)),
                          //   confirmButtonStyle: ButtonStyle(
                          //       backgroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.brown.shade300),
                          //       foregroundColor:
                          //           MaterialStateProperty.all<Color>(
                          //               Colors.green[900]!)),
                          //   hourMinuteTextStyle: const TextStyle(
                          //       fontSize:
                          //           30), // Text style for hours and minutes
                          // ),
                          // textTheme: TextTheme(
                          //   bodySmall: TextStyle(color: Colors.blueAccent),
                          // ),
                          // colorScheme: ColorScheme(
                          //   primary: Colors.deepPurple,
                          //   secondary: Colors.brown.shade300,
                          //   background: Colors.blueAccent,
                          //   surface: Colors.blueAccent,
                          //   onBackground: Colors.white,
                          //   onSurface: Colors.white,
                          //   onError: Colors.white,
                          //   onPrimary: Colors.white,
                          //   onSecondary: Colors.black,
                          //   brightness: Brightness.dark,
                          //   error: Colors.red,
                          // ),
                          // textSelectionTheme: const TextSelectionThemeData(
                          //   cursorColor: Colors.lightGreen,
                          //   selectionColor: Colors.lightGreen,
                          //   selectionHandleColor: Colors.lightGreen,
                          // ),
                          // cupertinoOverrideTheme: const CupertinoThemeData(
                          //   primaryColor: Colors.lightGreen,
                          // ),
                          // ),
                        )),
                        child: child!,
                      );
                    },
                  );
                },
                child: const Text("Show dialog color change"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.green[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      // dayBuilder: ({
      //   required date,
      //   textStyle,
      //   decoration,
      //   isSelected,
      //   isDisabled,
      //   isToday,
      // }) {
      //   Widget? dayWidget;
      //   if (date.day % 3 == 0 && date.day % 9 != 0) {
      //     dayWidget = Container(
      //       decoration: decoration,
      //       child: Center(
      //         child: Stack(
      //           alignment: AlignmentDirectional.center,
      //           children: [
      //             Text(
      //               MaterialLocalizations.of(context).formatDecimal(date.day),
      //               style: textStyle,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 27.5),
      //               child: Container(
      //                 height: 4,
      //                 width: 4,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(5),
      //                   color: isSelected == true
      //                       ? Colors.white
      //                       : Colors.grey[500],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   }
      //   return dayWidget;
      // },
      // yearBuilder: ({
      //   required year,
      //   decoration,
      //   isCurrentYear,
      //   isDisabled,
      //   isSelected,
      //   textStyle,
      // }) {
      //   return Center(
      //     child: Container(
      //       decoration: decoration,
      //       height: 36,
      //       width: 72,
      //       child: Center(
      //         child: Semantics(
      //           selected: isSelected,
      //           button: true,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 year.toString(),
      //                 style: textStyle,
      //               ),
      //               if (isCurrentYear == true)
      //                 Container(
      //                   padding: const EdgeInsets.all(5),
      //                   margin: const EdgeInsets.only(left: 5),
      //                   decoration: const BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     color: Colors.redAccent,
      //                   ),
      //                 ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   );
      // },
    );
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(15),
                value: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white,
              );
              Logger().e(values);
              if (values != null) {
                print("Jb");
                for (var e in values) {
                  print(e);
                }
                // ignore: avoid_print
                print(_getValueText(config.calendarType, values));
                setState(() {
                  _dialogCalendarPickerValue = values;
                });
              }
            },
            child: const Text('Open Calendar Dialog'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

const backColor = Color(0xFFF8F8F8);
const secondaryColor = Color(0xFFF05A76);
const cardPrimaryColor = Color(0xFFFFFFFF);
const cardSecondaryColor = Color(0xFFEEEEEE);

const textPrimaryColor = Colors.black;
const textSecondaryColor = Colors.black38;

Container getBoxButton(String img) => Container(
      height: 38,
      width: 38,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: cardPrimaryColor,
      ),
      child: Image.asset(img, fit: BoxFit.contain),
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

class MyDimens {
  static const bodyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Colors.white, Color(0xB3FFFFFF), Color(0x62FFFFFF)],
  );

  Gradient getHomeGradient(Color color) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(.9),
          color.withOpacity(.6),
          color.withOpacity(.4)
        ],
      );

  static const bodyShadow = [
    BoxShadow(
      color: Color.fromARGB(255, 144, 176, 208),
      blurRadius: 40,
      offset: Offset(5, 2),
    ),
    BoxShadow(
      color: Colors.white,
      blurRadius: 40,
      offset: Offset(-5, -2),
    ),
  ];

  Widget getTitleText(String title, Color color) => Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      );

  Widget getSubTitleText(String title, Color color) => Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 9.5, color: color),
      );

  Widget getTitleSeeAllText(String title, Function onTap) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: MyColor.blueSecondary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () => onTap,
            child: const Text(
              'See More',
              style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
          ),
        ],
      );

  Widget getDoctorCategory(String title) => Container(
        padding: const EdgeInsets.only(left: 7, top: 3, bottom: 3, right: 14),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
          color: MyColor.blueSecondary,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(4),
            right: Radius.circular(14),
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 9, color: Colors.white),
        ),
      );

  Container getButtonStyle({required Widget child}) => Container(
        height: kBottomNavigationBarHeight,
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: getHomeGradient(MyColor.skySecondary),
          boxShadow: bodyShadow,
        ),
        child: child,
      );

  Future<bool> showExitPopup(BuildContext context) async => await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App',
              style: TextStyle(
                  fontFamily: "Poppins_Regular", fontWeight: FontWeight.bold)),
          content: const Text('Do you want to exit SoowGood?',
              style: TextStyle(
                  fontFamily: "Poppins_Regular",
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins_Regular",
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins_Regular",
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      );
}

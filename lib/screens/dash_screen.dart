import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashScreen extends StatelessWidget {
  const DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColor.ashhLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 10,
            pinned: true,
            backgroundColor: const Color(0xFF01204E),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            )),
            automaticallyImplyLeading: false,
            expandedHeight: kToolbarHeight * 2.4,
            collapsedHeight: kToolbarHeight * 2.4,
            flexibleSpace: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/logo_main.png',
                        width: size.width * .4, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 10),
                  CmSearchField(controller: TextEditingController()),
                ],
              ),
            ),
            // notification icon
            actions: const [
              Icon(
                Icons.hail,
                color: MyColor.ashhLight,
                size: 30,
              ),
              Icon(
                Icons.military_tech_rounded,
                color: MyColor.ashhLight,
                size: 30,
              ),
              SizedBox(width: 7),
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20),
            sliver: SliverToBoxAdapter(child: PtHomeOfferCard()),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 40,
                (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(index.toString()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CmSearchField extends StatelessWidget {
  const CmSearchField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
            Colors.white,
            Color(0xB3FFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: false,
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: InputBorder.none,
                hintText: 'Search doctor',
                hintStyle: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 14,
                  letterSpacing: 1.3,
                  wordSpacing: 1.5,
                ),
              ),
              onSubmitted: (val) {},
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 50,
            padding: const EdgeInsets.all(9),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF01204E),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(CupertinoIcons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PtHomeOfferCard extends StatefulWidget {
  const PtHomeOfferCard({super.key});
  @override
  State<PtHomeOfferCard> createState() => _PtHomeOfferCardState();
}

class _PtHomeOfferCardState extends State<PtHomeOfferCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * .17,
          child: PageView.builder(
            controller: PageController(viewportFraction: .8),
            clipBehavior: Clip.none,
            itemCount: 2 * 5,
            onPageChanged: (val) => setState(() => _currentIndex = val),
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.symmetric(
                    vertical: _currentIndex == i ? 0 : 10, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: MyDimens().getHomeGradient(MyColor.skySecondary),
                  boxShadow: MyDimens.bodyShadow,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    "assets/images/banner${(i % 2) + 1}.jpg",
                    width: 120.0,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset("", width: 130);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            10,
            (index) {
              final isSelect = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                height: isSelect ? 13 : 6,
                width: isSelect ? 13 : 6,
                margin: EdgeInsets.symmetric(horizontal: isSelect ? 5 : 2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelect ? MyColor.bluePrimary : Colors.white,
                  boxShadow: isSelect ? MyDimens.bodyShadow : [],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _offerText(String title) => Text(
        title,
        style: const TextStyle(
            fontSize: 15, letterSpacing: 1.1, color: MyColor.bluePrimary),
      );
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

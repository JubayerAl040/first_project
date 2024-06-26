import 'package:first_project/screens/inapp_update_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Hive.initFlutter();
  // await Hive.openBox("login-info");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorLight: Colors.black,
        useMaterial3: false,
        primaryColor: Colors.white,
        // primarySwatch: MaterialColor(000000, ),
        dialogTheme: const DialogTheme(backgroundColor: Colors.yellow),
      ),
      home: const InAppUpdateScreen(),
    );
  }
}

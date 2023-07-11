import 'package:attendance/screens/homepage.dart';
import 'package:attendance/screens/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('email');
    if (user != null) {
      setState(() {
        isFirstTime = false;
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance',
        theme: ThemeData(),
        home: isFirstTime ? const LoginScreen() : const MyHomePage(),
      );
    });
  }
}

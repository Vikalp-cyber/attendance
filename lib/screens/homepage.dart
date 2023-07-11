// import 'package:attendance/attendence/attendence.dart';
import 'package:flutter/material.dart';

import 'attendence_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyAttendancePage(),
    );
  }
}

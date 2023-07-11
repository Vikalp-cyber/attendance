import 'package:attendance/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../attendence/attendence.dart';
import '../utils/color.dart';

class MyAttendancePage extends StatefulWidget {
  const MyAttendancePage({Key? key}) : super(key: key);

  @override
  _MyAttendancePageState createState() => _MyAttendancePageState();
}

class _MyAttendancePageState extends State<MyAttendancePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSubmitting = false;
  bool canCheckIn = true;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    checkCanCheckIn(); // Check canCheckIn status when the app starts
  }

  Future<void> checkCanCheckIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool storedCanCheckIn = prefs.getBool('canCheckIn') ?? true;
    String? lastTime = prefs.getString('lasttime');
    DateTime? lastCheckInTime;

    if (lastTime != null) {
      lastCheckInTime = DateTime.parse(lastTime);
    } else {
      lastCheckInTime = DateTime.now();
    }

    bool checkInAllowed = isCheckInAllowed(lastCheckInTime);

    setState(() {
      canCheckIn = checkInAllowed;
    });
  }

  bool isCheckInAllowed(DateTime lastCheckInTime) {
    DateTime now = DateTime.now();

    DateTime nextCheckInTime = lastCheckInTime.add(const Duration(seconds: 20));

    return now.isAfter(nextCheckInTime);
  }

  Future<void> updateCanCheckIn(bool newCanCheckIn, DateTime datetime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('canCheckIn', newCanCheckIn);
    prefs.setString('lasttime', datetime.toIso8601String());

    setState(() {
      canCheckIn = newCanCheckIn;
    });
  }

  void markCheckIn() {
    if (isSubmitting || !canCheckIn) {
      return; // Prevent multiple submissions or check-in before 5 minutes
    }

    setState(() {
      isSubmitting = true;
    });

    User? user = _auth.currentUser;
    if (user != null) {
      String name = user.displayName ?? '';
      String email = user.email ?? '';
      String date = '${DateTime.now().day}/'
          '${DateTime.now().month}/'
          '${DateTime.now().year}';
      String time = '${DateTime.now().hour}:'
          "${DateTime.now().minute}:"
          "${DateTime.now().second}";

      Attendance().submitFormcheckIn(name, email, date, time, (String result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Mycolor.lightgreen,
            content: Text(result),
            duration: const Duration(seconds: 2),
          ),
        );

        setState(() {
          isSubmitting = false;
          canCheckIn = false;
        });

        // Update canCheckIn after successful check-in
        updateCanCheckIn(false, DateTime.now());
      });
    }
  }

  void markCheckOut() {
    if (isSubmitting) return; // Prevent multiple submissions

    setState(() {
      isSubmitting = true;
    });

    User? user = _auth.currentUser;
    if (user != null) {
      String name = user.displayName ?? '';
      String email = user.email ?? '';
      String date = '${DateTime.now().day}/'
          '${DateTime.now().month}/'
          '${DateTime.now().year}';
      String time = '${DateTime.now().hour}:'
          "${DateTime.now().minute}:"
          "${DateTime.now().second}";
      Attendance().submitFormcheckOut(name, email, date, time, (String result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Mycolor.lightgreen,
            content: Text(result),
            duration: const Duration(seconds: 2),
          ),
        );

        setState(() {
          isSubmitting = false;
          canCheckIn = true;
        });

        // Update canCheckIn after successful check-out
        updateCanCheckIn(true, DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSubmitting
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Mycolor.darkgreen),
              ),
            )
          : Column(
              children: [
                CustomAppBar("Attendance", "Mark Your Attendance"),
                Center(
                  child: Container(
                    height: 10.h,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Mycolor.lightgreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: canCheckIn ? markCheckIn : null,
                      child: Text(
                        'Check In',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10.h,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Mycolor.lightgreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: markCheckOut,
                    child: Text(
                      'Check Out',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

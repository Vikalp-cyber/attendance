import 'package:attendance/services/firebase_auth.dart';
import 'package:attendance/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/color.dart';
import '../utils/textsize.dart';
import '../widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final Auth auth = Auth();
  void _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await auth.signUpWithEmailAndPassword(email, password, context);
    } else {
      // Show error message for empty email or password
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar("Register", "Create Your Account"),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(nameController, "Full Name", false),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(emailController, "Email", false),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(passwordController, "password", true),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(
                  repeatPasswordController, "Repeat Password", true),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
              width: double.infinity,
              height: 6.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                onPressed: _signUp,
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I have an Account",
                    style: MytexStyle.normalText,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Login", style: MytexStyle.textbutton))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

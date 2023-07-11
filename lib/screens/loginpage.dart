import 'package:attendance/screens/register.dart';
import 'package:attendance/services/firebase_auth.dart';
import 'package:attendance/utils/color.dart';
import 'package:attendance/utils/textsize.dart';
import 'package:attendance/widgets/appbar.dart';
import 'package:attendance/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Auth auth = Auth();

  void savingDetails(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await auth.signInWithEmailAndPassword(email, password, context);
      // Navigate to the next screen or do something else
    } else {
      // Show error message for empty email or password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Mycolor.lightgreen,
          content: const Text(
            'Please enter your email and password',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar("Sign In to Your Account", "Sign In to Your Account"),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(emailController, "Email", false),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
              child: CustomTextField(passwordController, "Password", true),
            ),
            Container(
              margin: EdgeInsets.only(left: 60.w),
              child: TextButton(
                child: Text(
                  "forgot password ?",
                  style: TextStyle(color: Mycolor.lightgreen, fontSize: 12.sp),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
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
                onPressed: () {
                  savingDetails(emailController.text);
                  signIn();
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Or Login With",
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 3.h),
                width: 50.w,
                height: 6.h,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 3.h,
                      child: SvgPicture.asset("assets/icons/google.svg"),
                    ),
                    Text(
                      "Login with Google",
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account?",
                    style: MytexStyle.normalText,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text("Register", style: MytexStyle.textbutton))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:attendance/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String text;
  bool secure;
  CustomTextField(this.controller, this.text, this.secure, {super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        obscureText: widget.secure,
        decoration: InputDecoration(
          labelText: widget.text,
          labelStyle: TextStyle(color: Mycolor.darkgreen),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Mycolor.darkgreen),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Mycolor.darkgreen), // Modify the color here
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

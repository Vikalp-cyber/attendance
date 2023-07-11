import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/color.dart';
import '../utils/textsize.dart';

class CustomAppBar extends StatelessWidget {
  String text1;
  String text2;
  CustomAppBar(this.text1, this.text2, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Mycolor.darkgreen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15.h, left: 5.w),
            child: Text(
              text1,
              style: MytexStyle.heading1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w, top: 1.h),
            child: Text(text2, style: MytexStyle.heading2),
          )
        ],
      ),
    );
  }
}

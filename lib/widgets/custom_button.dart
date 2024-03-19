import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../consttants.dart';

class CustomButtton extends StatelessWidget {
  CustomButtton({required this.text, required this.ontap});
  String text;
  VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}

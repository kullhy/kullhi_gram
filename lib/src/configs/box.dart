import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxMain {
  static SizedBox w(double size) => SizedBox(width: size.w);
  static SizedBox h(double size) => SizedBox(height: size.h);
  static SizedBox s(double size) => SizedBox(
        height: size.h,
        width: size.h,
      );
}
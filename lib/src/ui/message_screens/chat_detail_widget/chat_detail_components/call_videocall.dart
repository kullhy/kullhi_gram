import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';

Widget callVideoCall() {
  return Container(
    padding: EdgeInsets.all(15.w),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/icons/call.png",
              width: 30.w,
            ),
            Image.asset(
              "assets/icons/video_call.png",
              width: 30.w,
            ),
            Image.asset(
              "assets/icons/email.png",
              width: 30.w,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.only(top: 15.h),
          height: 2,
          color: Palette.gray68,
        )
      ],
    ),
  );
}

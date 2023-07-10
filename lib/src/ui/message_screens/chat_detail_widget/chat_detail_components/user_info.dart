import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';

Widget userInfo() {
  return Container(
    alignment: Alignment.topCenter,
    padding: EdgeInsets.all(15.w),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40.h,
          backgroundImage: const AssetImage(
            "assets/images/avt.jpeg",
            // fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Kim Hùng",
          overflow: TextOverflow.ellipsis,
          style: AppFont.t.s(20).w600,
        ),
        SizedBox(height: 5.h),
        Text(
          "minsoftware@gmail.com",
          overflow: TextOverflow.ellipsis,
          style: AppFont.t.s(20).w400,
        ),
      ],
    ),
  );
}

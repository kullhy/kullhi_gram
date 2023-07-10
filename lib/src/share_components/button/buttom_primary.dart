
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/app_fonts.dart';
import '../../configs/palette.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    Key? key,
    this.width,
    required this.text,
    required this.action,
    this.color = Palette.primary,
    this.height,
    this.textStyle,
  }) : super(key: key);

  final double? width;
  final String text;
  final Function()? action;
  final Color? color;
  final double? height;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: action != null ? color : Palette.primary.withOpacity(0.5),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? AppFont.t.w600.white,
          ),
        ),
      ),
    );
  }
}

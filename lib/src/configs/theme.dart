import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';

class AppTheme {
  static EdgeInsets mainHorizEdge = EdgeInsets.symmetric(horizontal: 20.w);
  static ThemeData themData = ThemeData(
    scaffoldBackgroundColor: Palette.background,
  );
  static InputDecorationTheme textFormField() => InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintStyle: AppFont.t.s().w400.hint,
        focusColor: Palette.blue,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Palette.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
      );

  static LinearGradient skeletonGradient = const LinearGradient(
    colors: [
      Color(0xFFD8E3E7),
      Palette.primary,
      Color(0xFFD8E3E7),
    ],
    stops: [
      0,
      0.5,
      0.9,
    ],
    begin: Alignment(-2.4, -0.2),
    end: Alignment(2.4, 0.2),
    tileMode: TileMode.clamp,
  );
}

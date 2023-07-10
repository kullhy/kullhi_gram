import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';


Future downloadAndGetPhoto(BuildContext context, String imagePath) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 850.h,
          color: Palette.primary,
          child: Image.file(File(imagePath)),
        ),
      );
    },
  );
}

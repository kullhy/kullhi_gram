import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:url_launcher/url_launcher.dart';

Widget textChat(
    BuildContext context, String messageTxt, bool isOutgoing, bool isAvt) {
  // Hàm kiểm tra xem messageTxt có chứa URL hay không
  bool containsUrl(String text) {
    final urlRegex =
        RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-&?=%.]+');
    return urlRegex.hasMatch(text);
  }

  // Hàm xử lý khi click vào URL
  void launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  if (isOutgoing) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: isOutgoing ? Palette.primary : Palette.grayBE,
                borderRadius: BorderRadius.circular(16),
              ),
              child: RichText(
                text: TextSpan(
                  text: messageTxt,
                  style: AppFont.t.s(14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (containsUrl(messageTxt)) {
                        launchURL(Uri.parse(messageTxt));
                      }
                    },
                ),
              ),
            ),
          ),
        ),
        isAvt
            ? const Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/avt.jpeg",
                  ),
                ),
              )
            : Expanded(flex: 1, child: Container()),
      ],
    );
  } else {
    return Row(
      children: [
        isAvt
            ? const Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/avt.jpeg",
                  ),
                ),
              )
            : Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                color: isOutgoing ? Palette.primary : Palette.grayBE,
                borderRadius: BorderRadius.circular(16),
              ),
              child: RichText(
                text: TextSpan(
                  text: messageTxt,
                  style: AppFont.t.s(14).w400,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (containsUrl(messageTxt)) {
                        launchURL(Uri.parse(messageTxt));
                      }
                    },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';

class DialogChoose extends StatelessWidget {
  const DialogChoose({
    this.titelStyle,
    this.contentStyle,
    this.leftStyle,
    this.rightStyle,
    required this.titelText,
    required this.content,
    this.onPressedContinue,
    this.onPressedStop,
    required this.leftText,
    required this.rightText,
    super.key,
  });
  final Function()? onPressedContinue;
  final Function()? onPressedStop;
  final String titelText;
  final String content;
  final String leftText;
  final String rightText;
  final TextStyle? titelStyle;
  final TextStyle? contentStyle;
  final TextStyle? leftStyle;
  final TextStyle? rightStyle;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titelText, style: titelStyle ?? AppFont.t.s(18).black),
      content: Text(content, style: contentStyle ?? AppFont.t.s(18).black),
      actions: <Widget>[
        MaterialButton(
          onPressed: onPressedContinue,
          child: Text(leftText, style: leftStyle ?? AppFont.t.s(16).black.w600),
        ),
        MaterialButton(
            onPressed: onPressedStop,
            child: Text(
              rightText,
              style: AppFont.t.s(16).black.w600,
            )),
      ],
    );
  }
}

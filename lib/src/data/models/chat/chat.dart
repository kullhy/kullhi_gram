import 'package:flutter/material.dart';
import 'package:tdlib/td_api.dart';

class Chat {
  Message? message;
  bool? isToday;
  bool? isAvt;
  String? type;
  Alignment? alignment;
  Map<String, Widget>? optionWidgetsChat;

  Chat({this.message, this.isToday, this.isAvt, this.type, this.alignment,this.optionWidgetsChat});
}

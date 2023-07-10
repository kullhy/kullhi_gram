import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/my_profile/user.dart';
class AppProvider with ChangeNotifier {
  AppProvider._();
  static final AppProvider instance = AppProvider._();

  String? token;

  String? refreshToken;
  User? user;
  Uint8List? avatar;


  String firebaseToken = "";

  static const String notificationToken = "token";

  static String urlImage = '';
  static String chinhSach = '';

  static String checkDeviceType() {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "android";
    } else {
      return "DTDD";
    }
  }

  void notify() {
    notifyListeners();
  }


}

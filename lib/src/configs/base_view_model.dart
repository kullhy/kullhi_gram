import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:min_soft_ware/src/configs/palette.dart';

import '../../app.dart';

abstract class BaseViewModel extends ChangeNotifier {
  // final Repository repository;
  // BaseViewModel(this.repository);

  final BuildContext curContext = navigatorKey.currentContext!;
  bool _counting = false;
  bool _loading = false;
  Timer? timer;

  int initTimeSmsOtp = 60;
  int initTimeMailOtp = 180;

  int page = 0;
  int limit = 20;
  bool isLastPage = false;

  bool get isLoading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isCounting => _counting;

  void startTimerSmsOtp() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (initTimeSmsOtp == 0) {
          timer.cancel();
          initTimeSmsOtp = 60;
          _counting = false;
        } else {
          _counting = true;
          initTimeSmsOtp--;
        }
        notifyListeners();
      },
    );
  }

  void startTimerMailOtp() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (initTimeMailOtp == 0) {
          timer.cancel();
          initTimeMailOtp = 180;
          _counting = false;
        } else {
          _counting = true;
          initTimeMailOtp--;
        }
        notifyListeners();
      },
    );
  }

  void showError(String? message) {
    Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.red,
      textColor: Palette.background,
      fontSize: 14.0,
    );
  }

  void showSuccess(String? code) {
    Fluttertoast.showToast(
      msg: code ?? "Error",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.success,
      textColor: Palette.background,
      fontSize: 14.0,
    );
  }

  void showToastNormal(String? code) {
    Fluttertoast.showToast(
      msg: code ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Palette.border,
      textColor: Palette.fontMain,
      fontSize: 14.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}


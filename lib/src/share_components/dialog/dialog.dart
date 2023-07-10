import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../configs/Palette.dart';
import '../../navigator/app_navigator.dart';
import '../loading/loading.dart';
import 'dialog_succes.dart';

enum ToastType { success, error, warning }

Future showLoading(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    useSafeArea: false,
    context: context,
    builder: (context) => const Loading(),
  );
}

Future showDialogSuccess(String title, BuildContext context, [String? desc, int timeForDismiss = 2000]) async {
  await dialogAnimationWrapper(
    context: context,
    timeForDismiss: timeForDismiss,
    child: DialogSuccess(
      text: title,
      desc: desc,
    ),
  );
}

Future dialogAnimationWrapper({
  required BuildContext context,
  child,
  duration = 400,
  backgroundColor = Colors.white,
  timeForDismiss,
}) {
  if (timeForDismiss != null) {
    Future.delayed(Duration(milliseconds: timeForDismiss), () {
      Navigator.pop(context);
    });
  }

  return showGeneralDialog(
    transitionDuration: Duration(milliseconds: duration),
    context: AppNavigator.context!,
    pageBuilder: (_, __, ___) => child,
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 0), end: const Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

Future<bool?> showError(String? message) {
  return Fluttertoast.showToast(
    msg: message ?? 'Lỗi không xác định',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Palette.red,
    textColor: Palette.background,
    fontSize: 14.0,
  );
}

Future<bool?> dismissLoadingShowError(String? message, BuildContext context) {
  Navigator.pop(context);
  return Fluttertoast.showToast(
    msg: message ?? 'Lỗi không xác định',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Palette.red,
    textColor: Palette.background,
    fontSize: 14.0,
  );
}

void dismissLoading(BuildContext context) {
  return Navigator.pop(context);
}

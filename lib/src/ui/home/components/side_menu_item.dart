import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:min_soft_ware/app.dart';
import 'package:min_soft_ware/src/services/telegram_service.dart';
import 'package:provider/provider.dart';

SideMenuItem menuIteam({required int priority,required String title,required SideMenuController sideMenu,required IconData icon, Function()? onError}) {
  return SideMenuItem(
    priority: priority,
    title: title,
    onTap: (index, _) {
      if (index == 6) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Bạn có chắc chắn muốn đăng xuất'),
              content: const Text('Vui lòng xác nhận'),
              actions: [
                TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    context.read<TelegramService>().logOut(
                      onError: (value) {
                        onError;
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        sideMenu.changePage(index);
      }
    },
    icon: Icon(icon),
  );
}

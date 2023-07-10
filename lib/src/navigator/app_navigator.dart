

import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/features/login/view/login_screen.dart';
import 'package:min_soft_ware/src/features/login/view_model/login_view_model.dart';
import 'package:min_soft_ware/src/features/splash/splash_screen.dart';
import 'package:min_soft_ware/src/navigator/routers.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../repository/manager_reponsitory.dart';
import '../ui/check_login/check_login_screens.dart';
import '../ui/code_entry/code_entry.dart';
import '../ui/home/home_screens.dart';
import '../ui/login_with_qr/login_with_qr.dart';

class AppNavigator {
  static Map<String, WidgetBuilder> router = {
    Routes.loginRoute: (BuildContext context) {
      return ChangeNotifierProvider<ChangeNotifier>(
        create: (context) => LoginViewModel(repository: PersonalRepository()),
        child: const LoginScreen(),
      );
    },
    Routes.splash: (BuildContext context) {
      return const SplashScreen();
    },
    Routes.otpRoute: (BuildContext context) {
      return const CodeEntryScreen();
    },
    Routes.qrRoute: (context) {
      return const LoginWithQrScreens();
    },
    Routes.checkLogin: (context) {
      return const CheckLoginScreens();
    },
    Routes.homeRoute: (context) {
      final String token = ModalRoute.of(context)?.settings.arguments as String;
      return HomeScreens(
        token: token,
      );
    },
  };

  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState get state => navigatorKey.currentState!;
}

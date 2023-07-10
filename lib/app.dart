import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/navigator/app_navigator.dart';
import 'package:min_soft_ware/src/navigator/routers.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
        designSize: const Size(1440, 1080),
        builder: (context, child) {
          return MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            routes: AppNavigator.router,
            title: 'Min Group SoftWare',
            theme: ThemeData.light(useMaterial3: true),
            initialRoute: Routes.splash,
          );
        },
      ),
    );
  }
}

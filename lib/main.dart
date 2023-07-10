import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:min_soft_ware/app.dart';
import 'package:min_soft_ware/src/features/personal/view_model/personal_view_model.dart';
import 'package:min_soft_ware/src/navigator/routers.dart';
import 'package:min_soft_ware/src/network/pref_data.dart';
import 'package:min_soft_ware/src/repository/manager_reponsitory.dart';
import 'package:min_soft_ware/src/repository/repository.dart';
import 'package:min_soft_ware/src/services/telegram_service.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_view_model.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chat_widget_view_model.dart';
import 'package:min_soft_ware/src/ui/message_screens/list_contacts/list_contacts_view_model.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/tdlib.dart';

GetIt getIt = GetIt.I;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager.init();
  Provider.debugCheckInvalidValueType = null;
  TdPlugin.initialize();
  if (Platform.isAndroid) {
    // await TdPlugin.initialize();0
  } else {
    Size size = await DesktopWindow.getWindowSize();
    await DesktopWindow.setMinWindowSize(
        Size(size.width * 0.5, size.height * 0.8));
    await DesktopWindow.setMinWindowSize(const Size(720, 520));
  }
  runApp(
    MultiProvider(
      providers: [
        Provider<TelegramService>(
          create: (_) => TelegramService(
              lastRouteName: Routes.splash, response: Repository()),
          lazy: false,
        ),
        Provider(create: (_) => Repository()),
        Provider(
            create: (_) => PersonalViewModel(personalRP: PersonalRepository())),
        Provider<ListContactsViewModel>(
          create: (_) => ListContactsViewModel(),
        ),
        Provider(
          create: (_) => ChatWidgetViewModel(0, ""),
        ),
        Provider(
          create: (_) => ChatDetailViewModel(listFile: [], listPhoto: []),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

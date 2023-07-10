import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chat_widget_view_model.dart';
import 'package:min_soft_ware/src/ui/message_screens/list_contacts/list_contacts_view_model.dart';
import 'package:provider/provider.dart';
import '../../utils/helpers/logger.dart';
import 'chat_detail_widget/chat_detail_view_model.dart';
import 'chat_widget/chat_wiget.dart';
import 'list_contacts/list_contacts.dart';

class MessagesScreens extends StatefulWidget {
  const MessagesScreens({Key? key}) : super(key: key);

  @override
  State<MessagesScreens> createState() => _MessagesScreensState();
}

class _MessagesScreensState extends State<MessagesScreens> {
  int chatId = 0;
  String userName = "";

  void setChatId(int id, String name) {
    Logger.d("set chat id ", id);
    setState(() {
      chatId = id;
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 300.w,
            child: ChangeNotifierProvider<ListContactsViewModel>(
                create: (context) => ListContactsViewModel(),
                child: ListContactsWidget(onChatIdSelected: setChatId))),
        chatId == 0
            ? Expanded(flex: 2, child: Container())
            : Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.background)),
                  child: MultiProvider(
                    providers: [
                      ChangeNotifierProvider<ChatWidgetViewModel>.value(
                        value: ChatWidgetViewModel(chatId, userName),
                        child: const ChatWidget(),
                      ),
                      Provider(
                        create: (_) =>
                            ChatDetailViewModel(listFile: [], listPhoto: []),
                      ),
                    ],
                    child: const ChatWidget(),
                  ),
                ),
              ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_components/photo_share.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_view_model.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:provider/provider.dart';
import 'chat_detail_components/call_videocall.dart';
import 'chat_detail_components/file_share.dart';
import 'chat_detail_components/user_info.dart';

class ChatDetailWidget extends StatefulWidget {
  const ChatDetailWidget({Key? key}) : super(key: key);
  @override
  State<ChatDetailWidget> createState() => _ChatDetailWidgetState();
}

class _ChatDetailWidgetState extends State<ChatDetailWidget> {
  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<ChatDetailViewModel>();
    return Scaffold(body: Consumer<ChatDetailViewModel>(
      builder: (context, value, child) {
        Logger.d("change fileShare", value.showAll);
        return ListView(
          children: [
            userInfo(),
            callVideoCall(),
            FileShare(
              value: value,
            ),
            PhotoShare(value: value,)
          ],
        );
      },
    ));
  }
}

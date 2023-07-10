import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chat_widget_view_model.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart' as td;

import '../../../../services/telegram_service.dart';
import '../../../../utils/helpers/logger.dart';

class SendWidget extends StatefulWidget {
  const SendWidget({Key? key, required this.chatId}) : super(key: key);

  final int chatId;

  @override
  State<SendWidget> createState() => _SendWidgetState();
}

String message = '';

void sendMessage(BuildContext context, String message, int chatId) async {
  final telegramService = Provider.of<TelegramService>(context, listen: false);

  final createPrivateChatResult =
      td.CreatePrivateChat(userId: chatId, force: false);
  final createChat = await telegramService.send(createPrivateChatResult);
  Logger.d("create new chat ${jsonEncode(createChat)}");
  final sendMessage = td.SendMessage(
    chatId: chatId,
    messageThreadId: 0,
    replyToMessageId: 0,
    options: null,
    replyMarkup: null,
    inputMessageContent: td.InputMessageText(
      text: td.FormattedText(
        entities: [],
        text: message,
      ),
      clearDraft: false,
      disableWebPagePreview: false,
    ),
  );
  await telegramService.send(sendMessage);
}

class _SendWidgetState extends State<SendWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatWidgetViewModel>();
    TextEditingController textEditingController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(15.w),
      height: 90.h,
      decoration: const BoxDecoration(color: Palette.white),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              // margin: const EdgeInsets.only(left: 15),
              padding: EdgeInsets.only(
                left: 30.w,
                bottom: 10.h,
                right: 30.w,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Palette.grayF6),
              child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Message',
                ),
                onSubmitted: (String vlue) {
                  message = textEditingController.text;
                  sendMessage(context, message, widget.chatId);
                  textEditingController.clear();
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                // style: ElevatedButton.styleFrom(shape: CircleBorder()),
                onPressed: () async {
                  final result = await viewModel.pickPhoto();
                  viewModel.sendFile(result.files.single.path!, "photo");
                },
                icon: Image.asset(
                  "assets/icons/photos.png",
                  height: 40.h,
                ),
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                // style: ElevatedButton.styleFrom(shape: CircleBorder()),
                onPressed: () async {
                  final result = await viewModel.pickFile();
                  Logger.d("link file pick", result.files.single.path);
                  viewModel.sendFile(result.files.single.path!, "document");
                },
                icon: Image.asset(
                  "assets/icons/send_file.png",
                  height: 40.h,
                ),
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {},
                icon: Image.asset(
                  "assets/icons/sticker.png",
                  height: 40.h,
                ),
              )),
        ],
      ),
    );
  }
}

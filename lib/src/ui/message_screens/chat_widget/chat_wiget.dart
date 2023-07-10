import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/data/models/chat/chat.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_view_model.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chat_widget_view_model.dart';
import 'package:provider/provider.dart';
import '../chat_detail_widget/chat_detail.dart';
import 'package:tdlib/td_api.dart' as td hide Text;
import 'chatWidgetComponents/send_widget.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);
  @override
  State<ChatWidget> createState() => _ChatWidget();
}

class _ChatWidget extends State<ChatWidget> {
  int x = 0;
  String message = '';

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<ChatWidgetViewModel>();
    return Consumer<ChatWidgetViewModel>(builder: (context, viewModel, child) {
      return Row(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Palette.grayBE.withOpacity(0.1),
              appBar: AppBar(
                backgroundColor: Palette.white,
                title: Text(
                  viewModel.userNameChat,
                  style: AppFont.t.s(20),
                ),
                elevation: 0,
                leading: Container(
                  padding: EdgeInsets.all(10.w),
                  margin: EdgeInsets.only(left: 10.w),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/avt.jpeg",
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            viewModel.detailScreens();
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          )),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: StreamBuilder<List<td.Message>>(
                      stream: viewModel.messageStreamController
                          .stream, // Sử dụng stream từ StreamController
                      builder: (context, snapshot) {
                        bool isUseToday = false;
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Container(
                              height: 1080.h,
                              width: 1440.w,
                              decoration: const BoxDecoration(color: Colors.red),
                              child: Center(
                                  child: Text(
                                'Error: ${snapshot.error}',
                                style: AppFont.t.s(20).w500,
                              )));
                        } else {
                          var messages = snapshot.data ?? [];
                          messages = messages.toList();
    
                          return ListView(
                            reverse: true,
                            children: messages.map((messageValue) {
                              Chat chat = viewModel.chatHandle(messageValue);
                              if (chat.isToday! || isUseToday) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: chat.message!.isOutgoing
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 450.w,
                                          child: Align(
                                            alignment: chat.alignment!,
                                            child: chat.optionWidgetsChat!
                                                    .containsKey(chat.type)
                                                ? chat
                                                    .optionWidgetsChat![chat.type]
                                                : Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                isUseToday = true;
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: chat.message!.isOutgoing
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 450.w,
                                          child: Align(
                                            alignment: chat.alignment!,
                                            child: chat.optionWidgetsChat!
                                                    .containsKey(chat.type)
                                                ? chat
                                                    .optionWidgetsChat![chat.type]
                                                : Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    const Text("Hôm nay"),
                                  ],
                                );
                              }
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SendWidget(chatId: viewModel.chatIdChat),
                  ),
                ],
              ),
            ),
          ),
          viewModel.isDetailScreen
              ? SizedBox(
                  width: 300.w,
                  child: ChangeNotifierProvider<ChatDetailViewModel>(
                    create: (context) => ChatDetailViewModel(
                       listFile:   viewModel.listFile, listPhoto:  viewModel.listPhoto),
                    child: const ChatDetailWidget(),
                  ))
              : Container(),
        ],
      )
      ;
    });
  }
}

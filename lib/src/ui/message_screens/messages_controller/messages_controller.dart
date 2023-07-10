// import 'dart:async';
// import 'dart:convert';
// import 'dart:io' as i;

// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:provider/provider.dart';
// import 'package:tdlib/td_api.dart';

// import '../../../services/telegram_service.dart';
// import '../../../utils/helpers/logger.dart';



// Future<void> downloadAndSaveImages(int fileId, BuildContext context) async {
//   var downloadFileRequest = DownloadFile(
//     fileId: fileId,
//     priority: 1,
//     synchronous: false,
//     limit: 0,
//     offset: 0,
//     // savePath: savePath;
//   );
//   final telegramService = Provider.of<TelegramService>(context, listen: false);
//   final downloadFileResult = await telegramService.send(downloadFileRequest);
//   // Tạo đường dẫn đầy đủ cho file
//   // final savePath = 'c:/my_custom_folder/file_$fileId.jpg';

//   // // Lưu file vào địa chỉ mới
//   // final file = i.File(savePath);
//   // await file.writeAsBytes(downloadFileResult.bytes);
//    Logger.d("check download file ${jsonEncode(downloadFileResult)}");
//   if (downloadFileResult is File) {
//     // return downloadFileResult;
//   } else {
//     return;
//   }
// }



// Future<void> openSavedFile(String filePath) async {
//   final result = await OpenFile.open(filePath);

//   if (result.type == ResultType.done) {
//      Logger.d('File opened successfully.');
//   } else {
//      Logger.d('Error opening file: ${result.message}');
//   }
// }

// //Lấy lịch sử chat
// Future<List<Message>> getChatHistory(BuildContext context, int chatId) async {
//   final telegramService = Provider.of<TelegramService>(context, listen: false);

//   final getChatHistory = GetChatHistory(
//     chatId: chatId,
//     fromMessageId: 0,
//     offset: 0,
//     limit: 100,
//     onlyLocal: false,
//   );

//   final result = await telegramService.send(getChatHistory);
//    Logger.d(jsonEncode(result));
//   if (result is Messages) {
//     result.messages[0].content;
//     return result.messages;
//   } else {
//     return [];
//   }
// }

// void sendFile(BuildContext context, int chatId, String filePath,
//     String sendOption) async {
//   // Tạo input file từ nội dung tệp ảnh
//   InputFile inputFile = InputFileLocal(
//     path: filePath,
//   );

//   // Gửi tệp ảnh qua TDLib
//   // td.MessageSendOptions action = td.MessageSendOptions.;
//   InputMessageContent photos = InputMessagePhoto(
//     photo: inputFile,
//     addedStickerFileIds: [],
//     width: 0,
//     height: 0,
//     caption: null,
//     ttl: 0,
//     thumbnail: null,
//   );

//   InputMessageContent document = InputMessageDocument(
//     thumbnail: null,
//     disableContentTypeDetection: true,
//     document: inputFile,
//   );

//   final telegramService = Provider.of<TelegramService>(context, listen: false);

//   final createPrivateChatResult =
//       CreatePrivateChat(userId: chatId, force: false);
//   final createChat = await telegramService.send(createPrivateChatResult);
//    Logger.d("create new chat ${jsonEncode(createChat)}");
//   final sendMessage = SendMessage(
//     chatId: chatId,
//     messageThreadId: 0,
//     replyToMessageId: 0,
//     options: null,
//     replyMarkup: null,
//     inputMessageContent: sendOption == "photo" ? photos : document,
//   );
//   await telegramService.send(sendMessage);
// }

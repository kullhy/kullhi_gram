import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:min_soft_ware/src/configs/base_view_model.dart';
import 'package:tdlib/td_api.dart' hide Chat, FileType;
import '../../../data/models/chat/chat.dart';
import '../../../data/models/file_local/file_local.dart';
import 'dart:convert';
import 'dart:io' as i;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../../../services/telegram_service.dart';
import '../../../utils/helpers/logger.dart';
import 'chatWidgetComponents/document_chat.dart';
import 'chatWidgetComponents/photo_chat.dart';
import 'chatWidgetComponents/text_chat.dart';

DateTime currentDate = DateTime.now();
DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
DateTime endDate = startDate.add(const Duration(days: 1));

class ChatWidgetViewModel extends BaseViewModel {
  
  ChatWidgetViewModel(int chatId, String userName) : super() {
    startChatHistoryUpdates(chatId);
    chatIdChat = chatId;
    userNameChat = userName;
  }
  int x = 0;
  bool isDetailScreen = false;
  final StreamController<List<Message>> messageStreamController = StreamController<List<Message>>(); // StreamController
  List<FileLocal> listFile = [];
  List<String> listPhoto = [];
  bool isUseToday = false;
  bool isChange = true;
  bool isAvt = true;
  String widgetChat = "";
  int chatIdChat = 0;
  String userNameChat = "";

  Chat chatHandle(Message messageValue) {
    String messageTxt = '';
    String? dataPhoto = "";
    int idPhoto = 0;
    int idDocument = 0;
    String pathPhoto = "";
    String documentName = "";
    bool isOutgoing = messageValue.isOutgoing;
    DateTime messageDate = DateTime.fromMillisecondsSinceEpoch(messageValue.date * 1000);
    bool isTodayMessage = messageDate.isAfter(startDate) && messageDate.isBefore(endDate);

    if (messageValue.content is MessageText) {
      MessageText messageText = messageValue.content as MessageText;
      FormattedText text = messageText.text;
      messageTxt = text.text;
      widgetChat = "text";
    } else if (messageValue.content is MessagePhoto) {
      widgetChat = "photo";
      MessagePhoto messagePhoto = messageValue.content as MessagePhoto;
      if (messagePhoto.photo.minithumbnail != null) {
        dataPhoto = messagePhoto.photo.minithumbnail!.data;
      } else {}
      int x = messagePhoto.photo.sizes.length;
      idPhoto = messagePhoto.photo.sizes[x - 1].photo.id;
      pathPhoto = messagePhoto.photo.sizes[x - 1].photo.local.path;
      addPhotoIfNotExists(pathPhoto);
      Logger.d("link ảnh", pathPhoto);
      downloadAndSaveImages(idPhoto, curContext);
    } else if (messageValue.content is MessageDocument) {
      widgetChat = "document";
      MessageDocument messageDocument = messageValue.content as MessageDocument;
      idDocument = messageDocument.document.document.id;
      documentName = messageDocument.document.fileName;
      final newFile = FileLocal(id: messageDocument.document.document.id, name: messageDocument.document.fileName, path: messageDocument.document.document.local.path);
      addFileIfNotExists(newFile);
    }

    if (isAvt) {
      isChange = isOutgoing;
    } else {
      if (isChange != isOutgoing) {
        isAvt = true;
        isChange = isOutgoing;
      } else {
        isAvt = false;
      }
    }
    final alignment = isOutgoing ? Alignment.centerRight : Alignment.centerLeft;
    Map<String, Widget> optionWidgetsChat = {
      "text": textChat(curContext, messageTxt, isOutgoing, isAvt),
      "photo": PhotoChat(
        dataPhoto: dataPhoto,
        idPhoto: idPhoto,
        pathPhoto: pathPhoto,
        isAvt: isAvt,
        isOutgoing: isOutgoing,
      ),
      "document": DocumentChat(
        documentName: documentName,
        isOutgoing: isOutgoing,
        idDocument: idDocument,
        isAvt: isAvt,
      )
    };
    isAvt = false;
    Chat chat = Chat(message: messageValue, isAvt: isAvt, isToday: isTodayMessage, type: widgetChat, alignment: alignment, optionWidgetsChat: optionWidgetsChat);
    return chat;
  }

  void detailScreens() {
    isDetailScreen = !isDetailScreen;
    notifyListeners();
  }

  void addPhotoIfNotExists(String pathPhoto) {
    if (!listPhoto.contains(pathPhoto)) {
      listPhoto.add(pathPhoto);
    }
  }

  void addFileIfNotExists(FileLocal file) {
    if (!listFile.contains(file)) {
      listFile.add(file);
    }
  }

  void startChatHistoryUpdates(int chatId) async {
    while (true) {
      if (chatId != x) {
        x = chatId;
        listFile = [];
        listPhoto = [];
      }
      final messages = await getChatHistory(chatId);
      Logger.d("tin nhắn", jsonEncode(messages));
      messageStreamController.add(messages);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> downloadAndSaveImages(int fileId, BuildContext context) async {
    var downloadFileRequest = DownloadFile(
      fileId: fileId,
      priority: 1,
      synchronous: false,
      limit: 0,
      offset: 0,
    );
    final telegramService = Provider.of<TelegramService>(context, listen: false);
    final downloadFileResult = await telegramService.send(downloadFileRequest);
    Logger.d("check download file ${jsonEncode(downloadFileResult)}");
    if (downloadFileResult is File) {
    } else {
      return;
    }
  }

  Future<void> downloadAndSaveFile(int fileId, String? savePath, String documentName) async {
    Logger.d("check download file 1 $fileId");
    var downloadFileRequest = DownloadFile(
      fileId: fileId,
      priority: 1,
      synchronous: false,
      limit: 0,
      offset: 0,
    );
    final telegramService = Provider.of<TelegramService>(curContext, listen: false);
    telegramService.send(downloadFileRequest);
    await Future.delayed(const Duration(seconds: 1));
    final downloadFileResult = await telegramService.send(downloadFileRequest);
    if (downloadFileResult is File) {
      Logger.d("Error moving file ${jsonEncode(downloadFileResult)}");
      final localPath = downloadFileResult.local.path;
      final file = i.File(localPath);
      Logger.d("Error moving file $localPath");
      final newPath = i.File('$savePath' r'\' '$documentName').path; // Địa chỉ lưu mới
      Logger.d("file đocument $newPath");
      // Di chuyển file vào địa chỉ lưu mới
      try {
        await file.copy(newPath);
        Logger.d("file đocument copy");
        await file.delete();
        Logger.d("file đocument xóa");
        await openSavedFile(newPath);
        i.File(newPath);
      } catch (e) {
        Logger.d('Error moving file: $e');
      }
    } else {}
  }

  Future<void> openSavedFile(String filePath) async {
    final result = await OpenFile.open(filePath);

    if (result.type == ResultType.done) {
      Logger.d('File opened successfully.');
    } else {
      Logger.d('Error opening file: ${result.message}');
    }
  }

  Future<List<Message>> getChatHistory(int chatId) async {
    final telegramService = Provider.of<TelegramService>(curContext, listen: false);

    final getChatHistory = GetChatHistory(
      chatId: chatId,
      fromMessageId: 0,
      offset: 0,
      limit: 100,
      onlyLocal: false,
    );

    final result = await telegramService.send(getChatHistory);
    Logger.d(jsonEncode(result));
    if (result is Messages) {
      result.messages[0].content;
      return result.messages;
    } else {
      return [];
    }
  }

  Future<FilePickerResult> pickPhoto() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    return result!;
  }

  Future<FilePickerResult> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );
    return result!;
  }

  void sendFile(String filePath, String sendOption) async {
    // Tạo input file từ nội dung tệp ảnh
    InputFile inputFile = InputFileLocal(
      path: filePath,
    );
    InputMessageContent photos = InputMessagePhoto(
      photo: inputFile,
      addedStickerFileIds: [],
      width: 0,
      height: 0,
      caption: null,
      ttl: 0,
      thumbnail: null,
    );

    InputMessageContent document = InputMessageDocument(
      thumbnail: null,
      disableContentTypeDetection: true,
      document: inputFile,
    );

    final telegramService = Provider.of<TelegramService>(curContext, listen: false);

    // final createPrivateChatResult =
    //     CreatePrivateChat(userId: chatIdChat, force: false);
    // final createChat = await telegramService.send(createPrivateChatResult);
    final sendMessage = SendMessage(
      chatId: chatIdChat,
      messageThreadId: 0,
      replyToMessageId: 0,
      options: null,
      replyMarkup: null,
      inputMessageContent: sendOption == "photo" ? photos : document,
    );
    final sendResuil = await telegramService.send(sendMessage);
    Logger.d("send file resuil", jsonEncode(sendResuil));
  }

  @override
  void dispose() {
    super.dispose();
    messageStreamController.close();
  }
}

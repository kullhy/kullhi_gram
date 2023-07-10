import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/base_view_model.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart';
import 'dart:io' as i;
import '../../../data/models/file_local/file_local.dart';
import '../../../services/telegram_service.dart';
import '../../../utils/helpers/logger.dart';

class ChatDetailViewModel extends BaseViewModel {
  ChatDetailViewModel(
      {required List<FileLocal> listFile, required List<String> listPhoto})
      : super() {
    fullListFile = listFile;
    fullListPhoto = listPhoto;
    displayedList = fullListFile.take(3).toList();
    displayedListPhoto = fullListPhoto.take(4).toList();
  }

  String folderSavePath = "";
  List<FileLocal> fullListFile = [];
  List<String> fullListPhoto = [];
  List<FileLocal> displayedList = [];
  List<String> displayedListPhoto = [];
  ValueNotifier<bool> showAllNotifier = ValueNotifier<bool>(false);

  bool get showAll => showAllNotifier.value;

  void toggleShowAllFile() {
    if (showAll) {
      displayedList = fullListFile.take(3).toList();
      ChangeNotifier();
    } else {
      displayedList = List.from(fullListFile);
      ChangeNotifier();
    }
    showAllNotifier.value = !showAllNotifier.value;
    Logger.d("change fileShare", displayedList);
    ChangeNotifier();
  }

  void toggleShowAllPhoTo() {
    if (showAll) {
      displayedListPhoto = fullListPhoto.take(4).toList();
      ChangeNotifier();
    } else {
      displayedListPhoto = List.from(fullListPhoto);
      ChangeNotifier();
    }
    showAllNotifier.value = !showAllNotifier.value;
    Logger.d("change fileShare", displayedListPhoto);
    ChangeNotifier();
  }

  Future<void> dowloadDocument(int idDocument, String documentName) async {
    try {
      final String? result = await getDirectoryPath();
      if (result != null) {
        folderSavePath = result;
      }
      downloadAndSaveFile(
        idDocument,
        folderSavePath,
        documentName,
      );
      ChangeNotifier();
    } catch (e) {
      Logger.d("Error selecting folder: $e");
    }
    Logger.d("check crash 1");
    ChangeNotifier();
  }

  Future<void> downloadAndSaveFile(
      int fileId, String? savePath, String documentName) async {
    Logger.d("check download file 1 $fileId");
    var downloadFileRequest = DownloadFile(
      fileId: fileId,
      priority: 1,
      synchronous: false,
      limit: 0,
      offset: 0,
    );
    final telegramService =
        Provider.of<TelegramService>(curContext, listen: false);
    telegramService.send(downloadFileRequest);
    await Future.delayed(const Duration(seconds: 1));
    final downloadFileResult = await telegramService.send(downloadFileRequest);
    if (downloadFileResult is File) {
      Logger.d("Error moving file ${jsonEncode(downloadFileResult)}");
      final localPath = downloadFileResult.local.path;
      final file = i.File(localPath);
      Logger.d("Error moving file $localPath");
      final newPath =
          i.File('$savePath' r'\' '$documentName').path; // Địa chỉ lưu mới
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
        // return null;
      }
    } else {
      // return null;
    }
  }

  Future<void> openSavedFile(String filePath) async {
    final result = await OpenFile.open(filePath);

    if (result.type == ResultType.done) {
      Logger.d('File opened successfully.');
    } else {
      Logger.d('Error opening file: ${result.message}');
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart';

import '../../../configs/base_view_model.dart';
import '../../../services/telegram_service.dart';
import '../../../utils/helpers/logger.dart';

class ListContactsViewModel extends BaseViewModel {
  ListContactsViewModel() : super() {
    listContact();
  }
  List<int> contacts = [];
  List<User> users = [];
  Map<int, List<String>> lastMessages = {};
  List<User> filteredUsers = [];
  // int lengthContacts = 11;
  List<bool> isSelectedList = List.filled(100, false);

  Future<List<int>> getContacts() async {
    final telegramService =
        Provider.of<TelegramService>(curContext, listen: false);
    const searchQuery = GetContacts();
    final result = await telegramService.send(searchQuery);
    Logger.d("get contact ", jsonEncode(result));

    if (result is Users) {
      final user = result.userIds;
      return user;
    } else {
      if (kDebugMode) {
        Logger.d("Khong lay duoc contact");
      }
      return [];
    }
  }

  Future<void> listContact() async {
    contacts = await getContacts();
    // if (!mounted) return;
    await getUserInfoForContacts();
    Logger.d("gọi được", jsonEncode(filteredUsers));
    notifyListeners();
  }

  Future<void> getUserInfoForContacts() async {
    final telegramService =
        Provider.of<TelegramService>(curContext, listen: false);
    int i = 0;
    for (final userId in contacts) {
      i = i + 1;
      final getUserQuery = GetUser(userId: userId);
      final result = await telegramService.send(getUserQuery);
      notifyListeners();
      Logger.d("user: ", jsonEncode(result));
      // if (!mounted) return;
      List<String> lastMessage = await getLastChat(userId);
      lastMessages[userId] = lastMessage;
      if (result is User) {
        users.add(result);
        filteredUsers.add(result);
        notifyListeners();
      } else {
        if (kDebugMode) {
          print('Failed to get user info for user ID: $userId');
        }
      }
    }
    isSelectedList = List.filled(filteredUsers.length, false);
    notifyListeners();
  }

  void addContact(dynamic phoneNumber, dynamic firstName) async {
    final telegramService =
        Provider.of<TelegramService>(curContext, listen: false);
    if (phoneNumber.isNotEmpty && firstName.isNotEmpty) {
      final contact = Contact(
        phoneNumber: phoneNumber,
        firstName: firstName,
        lastName: '',
        userId: 0,
        vcard: '',
      );
      List<Contact> contacts = [];
      contacts.add(contact);

      final addContactQuery = ImportContacts(
        contacts: contacts,
      );

      final result = await telegramService.send(addContactQuery);
      Logger.d("add ${jsonEncode(result)}");
    }
  }

  Future<List<String>> getLastChat(int chatId) async {
    final telegramService =
        Provider.of<TelegramService>(curContext, listen: false);

    final getChatHistory = GetChatHistory(
      chatId: chatId,
      fromMessageId: 0,
      offset: 0,
      limit: 1,
      onlyLocal: false,
    );

    final result = await telegramService.send(getChatHistory);
    List<String> lastMessage = [];
    Logger.d(jsonEncode(result));
    if (result is Messages) {
      final messageValue = result.messages[0];
      final messageDate =
          DateTime.fromMillisecondsSinceEpoch(messageValue.date * 1000);
      final formattedDate = DateFormat('h:mm a').format(messageDate);
      if (messageValue.content is MessageText) {
        MessageText messageText = messageValue.content as MessageText;
        FormattedText text = messageText.text;
        lastMessage.add(text.text);
      } else if (messageValue.content is MessagePhoto) {
        lastMessage.add("Ảnh");
      } else if (messageValue.content is MessageDocument) {
        MessageDocument messageDocument =
            messageValue.content as MessageDocument;
        lastMessage.add(messageDocument.document.fileName);
      }
      lastMessage.add(formattedDate.toString());
    } else {
      lastMessage = [" ", " "];
    }
    return lastMessage;
  }

  void filterUsers() {
    if (searchQuery.isEmpty) {
      // Nếu giá trị tìm kiếm trống, hiển thị toàn bộ danh sách người dùng
      filteredUsers = users;
      notifyListeners();
    } else {
      // Nếu có giá trị tìm kiếm, lọc danh sách người dùng dựa trên firstName và lastName
      filteredUsers = users.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(searchQuery.toLowerCase());
      }).toList();
      notifyListeners();
    }
    notifyListeners();
  }

  String searchQuery = '';
  Set<int> selectedItems = {};
}

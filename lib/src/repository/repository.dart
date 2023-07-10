import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:min_soft_ware/app.dart';
import 'package:min_soft_ware/src/network/base_dio.dart';
import 'package:min_soft_ware/src/share_components/dialog/dialog.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart' as td hide Text;
import '../data/local/app_data.dart';
import '../data/models/my_profile/login_model.dart';
import '../data/models/my_profile/status.dart';
import '../network/api_path.dart';
import '../services/telegram_service.dart';

class Repository {
  late Dio dioHelper;
  Repository() {
    dioHelper = BaseDio.instance.dio;
  }

  void check() async {
    final loginPhoneNumber = await getMe();
    String changePhone = change(loginPhoneNumber);
    login(changePhone);
  }

  Future<String> getMe() async {
    final telegramService = Provider.of<TelegramService>(navigatorKey.currentContext!, listen: false);
    const getMe = td.GetMe();
    final result = await telegramService.send(getMe);
    Logger.d("get me ${jsonEncode(result)}");
    if (result is td.User) {
      return result.phoneNumber;
    } else {
      return '';
    }
  }

  String change(String phone) {
    if (phone.length >= 2) {
      return '0${phone.substring(2)}';
    } else {
      return phone;
    }
  }

  Future<void> login(String phone) async {
    LoginModel personal = LoginModel();
    await dioHelper.post(ApiPath.signIn, data: {"phone": phone}).then(
      (res) async {
        personal = LoginModel.fromJson(res.data);
        personal.status = Status.fromJson(res.data['status']);
        if (personal.status?.code == 200 && personal.status?.message == 'sucess') {
          AppProvider.instance.token = personal.token;
        } else {
          showError("Số điện thoại chưa được đăng ký");
        }
      },
    );
  }
}

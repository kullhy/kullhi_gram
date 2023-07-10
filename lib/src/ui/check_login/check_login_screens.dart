import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/data/local/app_data.dart';
import 'package:min_soft_ware/src/network/api_path.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart' as td hide Text;
import '../../navigator/routers.dart';
import '../../services/telegram_service.dart';
import '../../utils/helpers/logger.dart';

String token = "";

class CheckLoginScreens extends StatefulWidget {
  const CheckLoginScreens({Key? key}) : super(key: key);

  @override
  State<CheckLoginScreens> createState() => _CheckLoginScreensState();
}

Future<String> getMe(BuildContext context) async {
  final telegramService = Provider.of<TelegramService>(context, listen: false);
  const getMe = td.GetMe();
  final result = await telegramService.send(getMe);
  Logger.d("get me }", jsonEncode(result));
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

class _CheckLoginScreensState extends State<CheckLoginScreens> {
  bool isCheckLogin = false;
  bool isLoading = true;
  // String token = "";

  Future<void> checkLogin(String phone) async {
    var data = jsonEncode({"phone": phone});
    var response = await http.post(
      Uri.parse(ApiPath.signIn),
      body: data,
    );
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['status'];
      final message = status['message'];
      token = responseData['token'];

      setState(
        () {
          AppProvider.instance.token = token;
          isLoading = false;
        },
      );
      if (message == "success") {
        setState(() {
          isCheckLogin = true;
        });
      } else {}
    } else {
      Logger.d('Error: ${response.statusCode}');
    }
  }

  void check() async {
    final loginPhoneNumber = await getMe(context);
    String changePhone = change(loginPhoneNumber);
    checkLogin(changePhone);
  }

  @override
  initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckLogin) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute, (route) => false, arguments: token);
        Logger.d("check token in checkLogin", token);
        // AppNavigator.push(Routes.homeRoute,arguments: token);
      });
    }
    return Center(
        child: isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Palette.primary,
              )
            : Center(
                child: Container(
                    child: isCheckLogin == false
                        ? Column(
                            children: [
                              Text("Số điện thoại của bạn chưa được đăng ký", style: AppFont.t.s(16).w600.blue),
                              TextButton(
                                  onPressed: () async {
                                    await context.read<TelegramService>().logOut(onError: _handelError);
                                  },
                                  child: const Text("Logout"))
                            ],
                          )
                        : Text("Đang kiểm tra...", style: AppFont.t.s(16).w600.blue)),
              ));
  }

  void _handelError(td.TdError error) async {
    setState(() {});
  }
}

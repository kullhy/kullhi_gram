import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/gen/assets.gen.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart' as td hide Text;

import '../../services/telegram_service.dart';

class LoginWithQrScreens extends StatefulWidget {
  const LoginWithQrScreens({Key? key}) : super(key: key);

  @override
  State<LoginWithQrScreens> createState() => _LoginWithQrScreensState();
}

class _LoginWithQrScreensState extends State<LoginWithQrScreens> {
  String qrError = "";
  String qrCodeLink = "";
  bool isAndroid = false;

  final TextEditingController t = TextEditingController();
  String authState = "showQR";

  void qrListener(String link) {
    authState = "showQR";
  }

  @override
  void initState() {
    context.read<TelegramService>().requestQR(onError: _handelError);
    handleAuthorizationState();
    if (Platform.isAndroid) {
      isAndroid = true;
    } else {
      isAndroid = false;
    }
    super.initState();
  }

  void handleAuthorizationState() {
    late td.AuthorizationState authState;
    authState = tdState;
    Logger.d("trạng thái tại màn hình", tdState);
    if (authState is td.AuthorizationStateWaitOtherDeviceConfirmation) {
      qrCodeLink = authState.link;
      // Sử dụng qrCodeLink trong ứng dụng của bạn
    }
  }

  void _handelError(td.TdError error) async {
    setState(() {
      qrError = error.message;
      Logger.d("error $qrError");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isAndroid
          ? Container(
              // padding: EdgeInsets.all(size.width * 0.2),
              margin: EdgeInsets.only(left: 100.w, right: 100.w, top: 300.h, bottom: 200.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Palette.primary,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Text("Scan QR TO LOGIN", style: AppFont.t.s(20).primary.w600),
                  ),
                  // const Spacer(),
                  PrettyQr(
                    image: const AssetImage('assets/images/logo.png'),
                    size: 1000.w,
                    data: qrCodeLink,
                    errorCorrectLevel: QrErrorCorrectLevel.L,
                    roundEdges: true,
                    elementColor: Theme.of(context).textTheme.bodyLarge!.color ?? Colors.white,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<TelegramService>().requestQR(onError: _handelError);
                    },
                    child: const Text("Login with QR"),
                  ),
                  const Spacer(),
                ],
              ),
            )
          : Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Assets.image.logo.image(height: 300.h, width: 300.w),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.08, right: size.width * 0.08, top: size.width * 0.1, bottom: size.width * 0.1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Palette.primary,
                  ),
                  child: Column(
                    children: [
                      // const Spacer(),
                      Text("Scan QR TO LOGIN", style: AppFont.t.blue.s(24).w600),
                      const Spacer(),
                      Expanded(
                        child: PrettyQr(
                          // image: const AssetImage('assets/images/logo.png'),
                          size: 300.h,
                          data: qrCodeLink,
                          errorCorrectLevel: QrErrorCorrectLevel.L,
                          roundEdges: true,
                          elementColor: Theme.of(context).textTheme.bodyLarge!.color ?? Colors.white,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<TelegramService>().close(onError: _handelError);
                        },
                        child: const Text("Login with phone number"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

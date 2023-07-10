// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/data/local/app_data.dart';

import '../utils/helpers/logger.dart';

class ResponseInterceptor extends Interceptor {
  late final tokenCtrl = TextEditingController();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.type == DioErrorType.badResponse) {
      if (err.response!.statusCode == 401) {
      } else if (err.response!.statusCode == 400) {
        handler.resolve(err.response!);
      } else if (err.response!.statusCode == 500) {
        handler.resolve(err.response!);
      }
    } else if (err.type == DioErrorType.connectionTimeout) {
    } else if (err.type == DioErrorType.receiveTimeout) {
    } else {
      handler.resolve(err.response!);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      //       try {
      //   final AuthenticationRepository authenRepoImpl = getIt<AuthenticationRepository>();
      //   final res = await authenRepoImpl.refreshToken(appData.rfid);
      //   if (res.content != null) {
      //     appData.accessToken = res.content?.accessToken ?? '';
      //   } else {
      //     showError("Phiên đăng nhập hết hạn, vui lòng đăng nhập lại");
      //     appData.clear();
      //     AppNavigator.pushAndRemoveUntil(Routes.signInScreen);
      //   }
      // } catch (e) {
      //   showError("Phiên đăng nhập hết hạn, vui lòng đăng nhập lại");
      //   appData.clear();
      //   AppNavigator.pushAndRemoveUntil(Routes.signInScreen);
      // }
      // showError("Phiên đăng nhập hết hạn, vui lòng đăng nhập lại");
      // appData.clear();
      // AppNavigator.pushAndRemoveUntil(Routes.signInScreen);
    } else {
      handler.resolve(response);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.d('ACCESS TOKEN', AppProvider.instance.token);
    if (AppProvider.instance.token != null) {
      //   var expiration = await TokenRepository().getAccessTokenRemainingTime();
      //
      //   if (expiration.inSeconds < 60) {
      //     dio.interceptors.requestLock.lock();
      //
      //     // Call the refresh endpoint to get a new token
      //     await UserService()
      //         .refresh()
      //         .then((response) async {
      //       await TokenRepository().persistAccessToken(response.accessToken);
      //       accessToken = response.accessToken;
      //     }).catchError((error, stackTrace) {
      //       handler.reject(error, true);
      //     }).whenComplete(() => dio.interceptors.requestLock.unlock());
      //   }
      //

      options.headers['Authorization'] = AppProvider.instance.token;
      // if (options.path != ApiPath.checkToken &&
      //     options.path != ApiPath.refestToken &&
      //     options.path != ApiPath.activeDevice) {
      //   await checkToken();
      // }
    }
    return handler.next(options);
  }
}

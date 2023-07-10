import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' show Random;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:min_soft_ware/app.dart';
import 'package:min_soft_ware/src/navigator/routers.dart';
import 'package:min_soft_ware/src/repository/repository.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tdlib/tdlib.dart';
import 'package:tdlib/td_api.dart';

int _random() => Random().nextInt(10000000);
late AuthorizationState tdState;

class TelegramService extends ChangeNotifier {
  final Repository response;
  late int _client;
  late StreamController<TdObject> _eventController;
  late StreamSubscription<TdObject> _eventReceiver;
  final StreamController<Update> _updateController = StreamController<Update>.broadcast();
  Stream<Update> get updateStream => _updateController.stream;
  Map results = <int, Completer>{};
  Map callbackResults = <int, Future<void>>{};
  late Directory appDocDir;
  late Directory appExtDir;
  String lastRouteName;

  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  bool _isClientInitialized = false;

  TelegramService({this.lastRouteName = Routes.splash, required this.response}) {
    _eventController = StreamController();
    _eventController.stream.listen(_onEvent);
    initClient();
  }

  void initClient() async {
    _client = tdCreate();
    _isClientInitialized = true;
    appDocDir = await getApplicationDocumentsDirectory();
    appExtDir = await getTemporaryDirectory();
    execute(const SetLogVerbosityLevel(newVerbosityLevel: 1));
    tdSend(_client, const GetCurrentState());
    _isolate = await Isolate.spawn(_receive, _receivePort.sendPort, debugName: "isolated receive");
    _receivePort.listen(_receiver);
  }

  static _receive(sendPortToMain) async {
    TdNativePlugin.registerWith();
    // print(checkPlatform());
    if (Platform.isAndroid) {
      await TdPlugin.initialize();
    } else {
      await TdPlugin.initialize("tdjson.dll");
    }
    //var x = _rawClient.td_json_client_create();
    while (true) {
      final s = TdPlugin.instance.tdReceive();
      if (s != null) {
        sendPortToMain.send(s);
      }
    }
  }

  void _receiver(dynamic newEvent) async {
    final event = convertToObject(newEvent);
    if (event == null) {
      return;
    }
    if (event is Updates) {
      for (var event in event.updates) {
        _eventController.add(event);
      }
    } else {
      _eventController.add(event);
    }
    await _resolveEvent(event);
  }

  Future _resolveEvent(event) async {
    if (event.extra == null) {
      return;
    }
    final int extraId = event.extra;
    if (results.containsKey(extraId)) {
      results.remove(extraId).complete(event);
    } else if (callbackResults.containsKey(extraId)) {
      await callbackResults.remove(extraId);
    }
  }

  void stop() {
    _eventController.close();
    _eventReceiver.cancel();
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
  }

  void _onEvent(TdObject event) async {
    switch (event.getConstructor()) {
      case UpdateAuthorizationState.CONSTRUCTOR:
        tdState = (event as UpdateAuthorizationState).authorizationState;
        await _authorizationController(
          (event).authorizationState,
          isOffline: true,
        );
        break;
      default:
        return;
    }
  }

  Future _authorizationController(
    AuthorizationState authState, {
    bool isOffline = false,
  }) async {
    String route;
    Logger.d("Trạng thái", tdState);
    switch (authState.getConstructor()) {
      case AuthorizationStateWaitTdlibParameters.CONSTRUCTOR:
        await send(
          SetTdlibParameters(
            parameters: TdlibParameters(
              useTestDc: false,
              useSecretChats: true,
              useMessageDatabase: true,
              useFileDatabase: true,
              useChatInfoDatabase: true,
              ignoreFileNames: true,
              enableStorageOptimizer: true,
              systemLanguageCode: 'EN',
              filesDirectory: '${appExtDir.path}/tdlib',
              databaseDirectory: appDocDir.path,
              applicationVersion: '0.0.1',
              deviceModel: 'Unknown',
              systemVersion: 'Unknonw',
              apiId: 20790664,
              apiHash: '6f68bd1c0c2443053c645f86c270a9fa',
            ),
          ),
        );
        return;
      case AuthorizationStateWaitEncryptionKey.CONSTRUCTOR:
        if ((authState as AuthorizationStateWaitEncryptionKey).isEncrypted) {
          await send(
            const CheckDatabaseEncryptionKey(
              encryptionKey: 'mostrandomencryption',
            ),
          );
        } else {
          await send(
            const SetDatabaseEncryptionKey(
              newEncryptionKey: 'mostrandomencryption',
            ),
          );
        }
        return;
      case AuthorizationStateWaitPhoneNumber.CONSTRUCTOR:
        route = Routes.loginRoute;
        break;
      case AuthorizationStateClosed.CONSTRUCTOR:
        _client = tdCreate();
        _isClientInitialized = true;
        route = Routes.loginRoute;

        break;

      case AuthorizationStateReady.CONSTRUCTOR:
        response.check();
        route = Routes.checkLogin;
        break;
      case AuthorizationStateWaitCode.CONSTRUCTOR:
        route = Routes.otpRoute;
        break;
      case AuthorizationStateWaitOtherDeviceConfirmation.CONSTRUCTOR:
        route = Routes.qrRoute;

        break;
      case AuthorizationStateWaitRegistration.CONSTRUCTOR:
        return;
      case AuthorizationStateWaitPassword.CONSTRUCTOR:
        return;
      case AuthorizationStateLoggingOut.CONSTRUCTOR:
        route = Routes.logoutRoute;
        break;
      case AuthorizationStateClosing.CONSTRUCTOR:
        return;
      default:
        return;
    }

    if (route == lastRouteName) return;
    lastRouteName = route;
    Navigator.pushNamed(navigatorKey.currentContext!, route);
  }

  void destroyClient() async {
    tdSend(_client, const Close());
  }

  Future<TdObject?> send(event, {Future<void>? callback}) async {
    final rndId = _random();
    if (callback != null) {
      callbackResults[rndId] = callback;
      try {
        tdSend(_client, event, rndId);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      final completer = Completer<TdObject>();
      results[rndId] = completer;
      tdSend(_client, event, rndId);
      return completer.future;
    }
    return null;
  }

  TdObject execute(TdFunction event) => tdExecute(event)!;

  Future setAuthenticationPhoneNumber(
    String phoneNumber, {
    required void Function(TdError) onError,
  }) async {
    final result = await send(
      SetAuthenticationPhoneNumber(
        phoneNumber: phoneNumber,
        settings: const PhoneNumberAuthenticationSettings(
          allowFlashCall: false,
          isCurrentPhoneNumber: false,
          allowSmsRetrieverApi: false,
          allowMissedCall: true,
          authenticationTokens: [],
        ),
      ),
    );
    if (result != null && result is TdError) {
      onError(result);
    }
  }

  Future<List<int>> getContacts() async {
    if (!_isClientInitialized) {
      initClient();
    }
    Logger.d("call on service");
   
    Logger.d("Trạng thái",tdState);
    final result = await send(const GetContacts());
    final completer = Completer<List<int>>();
    if (result != null && result is Users) {
      completer.complete(result.userIds);
    } else {
      Logger.d("Không lấy được danh sách liên hệ");
      Logger.d("Khong tim được liên hệ");
      completer.complete([]);
    }
    return completer.future;
  }

  Future requestQR({
    required void Function(TdError) onError,
  }) async {
    AuthorizationState authState = const AuthorizationState();
    Logger.d("Trạng thái rqqr ",authState);

    await send(const RequestQrCodeAuthentication(otherUserIds: []));
  }

  Future checkAuthenticationCode(
    String code, {
    required void Function(TdError) onError,
  }) async {
    final result = await send(
      CheckAuthenticationCode(
        code: code,
      ),
    );
    if (result != null && result is TdError) {
      onError(result);
    }
  }

  Future close({
    required void Function(TdError) onError,
  }) async {
    AuthorizationState authState = const AuthorizationState();
    Logger.d("Trạng thái close ",authState);

    await send(const Close());
  }

  Future logOut({
    required void Function(TdError) onError,
  }) async {
    AuthorizationState authState = const AuthorizationState();
    Logger.d("Trạng thái lohout",authState);

    await send(const LogOut());
    _client = tdCreate();
    _isClientInitialized = true;
  }
}

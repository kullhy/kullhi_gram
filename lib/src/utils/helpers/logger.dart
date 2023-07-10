import 'dart:developer' as developer;

class Logger {
  static const String tag = "APP";

  static d([String tag = tag, dynamic message]) =>
      developer.log('>>>>>>>> $message', name: tag);

  static final Logger _instance = Logger._internal();

  static void devLog(Object ob) => developer.log(ob.toString(), name: 'DevLog');

  factory Logger() => _instance;

  Logger._internal();
}

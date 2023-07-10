class StatusCode {
  static const int ok = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int internalSeverError = 500;
  static const int badGateway = 502;
  static List<int> get validateStatus => [403, 404, 500, 502];
}

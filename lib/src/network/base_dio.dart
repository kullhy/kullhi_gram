import 'package:dio/dio.dart';
import 'package:min_soft_ware/src/data/local/app_data.dart';
import 'package:min_soft_ware/src/network/network.dart';
import 'api_path.dart';
import 'my_dio_logger.dart';

class BaseDio {
  static final BaseOptions _options = BaseOptions(
    contentType: 'application/json',
    receiveDataWhenStatusError: true,
    responseType: ResponseType.json,
    baseUrl: ApiPath.baseUrl,
    receiveTimeout: const Duration(seconds: 180),
    connectTimeout: const Duration(seconds: 180),
    validateStatus: (status) {
      return true;
    },
  );
  static final Dio _dio = Dio(_options);

  BaseDio._internal() {
    _dio.interceptors.add(MyDioLogger());
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (request, handler) async {
        final token = AppProvider.instance.token;
        request.headers["Authorization"] = "$token";
      }),
    );
  }

  static final BaseDio instance = BaseDio._internal();

  Dio get dio => _dio;
}

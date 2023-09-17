import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/config/const.dart';

class HttpInterceptor {
  constructor() {}

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: APP_API_URL,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    ),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void addHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }
}

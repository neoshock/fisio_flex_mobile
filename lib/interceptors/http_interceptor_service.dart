import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/config/const.dart';

class HttpInterceptor {
  constructor() {}

  late Dio dio = Dio(
    BaseOptions(
      baseUrl: APP_API_URL,
      receiveDataWhenStatusError: true,
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void addHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }
}

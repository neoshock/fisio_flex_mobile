import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/config/const.dart';
import 'package:fisioflex_mobile/interceptors/http_auth_interceptor_service.dart';

class HttpInterceptor {
  constructor() {
    addInterceptor(AuthInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: APP_API_URL,
    ),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void addHeaders(Map<String, dynamic> headers) {
    dio.options.headers.addAll(headers);
  }
}

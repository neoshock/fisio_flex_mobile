import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/core/auth/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = options.headers;
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = '*/*';
    options.headers = headers;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //error 400
    if (err.response?.statusCode == 400) {
      return handler.reject(
          DioError(requestOptions: err.requestOptions, error: err.response));
    }
    //    error 5xx
    if (err.response?.statusCode == 500) {
      return handler.reject(
          DioError(requestOptions: err.requestOptions, error: err.response));
    }
    return handler.next(err);
  }
}

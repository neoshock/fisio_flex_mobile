import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/interceptors/http_interceptor_service.dart';
import 'package:flutter/material.dart';

class AuthService {
  final HttpInterceptor _httpInterceptor = HttpInterceptor();

  // create method get, post
  Future<Response> login(String username, String password) async {
    try {
      final dio = _httpInterceptor.dio; // Obtén una instancia de dio
      _httpInterceptor.addHeaders(
        {'identification': username},
      );
      _httpInterceptor.addHeaders(
        {'password': password},
      );
      final response = await dio.post(
        'auth/login',
      );
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al iniciar sesión'},
        statusCode: 500,
        statusMessage: 'Credenciales invalidas',
      );
    }
  }

  Future<Response> getUserByIdentification(String token) async {
    try {
      final dio = _httpInterceptor.dio; // Obtén una instancia de dio
      _httpInterceptor.addHeaders(
        {'Authorization': 'Bearer $token'},
      );
      debugPrint(token);
      final response = dio.get(
        'user/my-profile',
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(
        requestOptions: RequestOptions(path: ''),
        data: {'error': 'Error al iniciar sesión'},
        statusCode: 500,
        statusMessage: 'Error al iniciar sesión',
      );
    }
  }
}

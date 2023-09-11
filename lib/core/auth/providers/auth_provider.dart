import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/core/auth/models/user_model.dart';
import 'package:fisioflex_mobile/core/auth/repositories/auth_repository.dart';
import 'package:fisioflex_mobile/core/auth/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(); // Define la lógica de autenticación en AuthProvider.
});

class AuthState {
  final bool isAuthenticated;
  AuthState({required this.isAuthenticated});
}

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState(isAuthenticated: false));

  final AuthService authService = AuthService();
  final authRepository = AuthRepository();

  Future<Response> login(String username, String password) async {
    final response = await authService.login(username, password);
    if (response.statusCode == 201) {
      await authRepository.saveAuthToken(response.data['data']['token']);
      state = AuthState(isAuthenticated: true);
      return response;
    } else {
      return Response(
          requestOptions: RequestOptions(path: ''),
          data: response.data,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage);
    }
  }

  Future<void> logout() async {
    await authRepository.removeAuthToken();
    state = AuthState(isAuthenticated: false);
  }

  Future<bool> checkIfAuthenticated() async {
    final token = await authRepository.getAuthToken();
    if (token != null) {
      state = AuthState(isAuthenticated: true);
    }
    return token != null;
  }

  Future<UserModel> getUserByIdentification() async {
    final token = await authRepository.getAuthToken();
    final response = authService.getUserByIdentification(token!);
    return response.then((value) => UserModel.fromJson(value.data['data']));
  }
}

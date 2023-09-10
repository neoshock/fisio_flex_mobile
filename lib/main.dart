import 'package:dio/dio.dart';
import 'package:fisioflex_mobile/config/theme.dart';
import 'package:fisioflex_mobile/core/auth/providers/auth_provider.dart';
import 'package:fisioflex_mobile/core/auth/repositories/auth_repository.dart';
import 'package:fisioflex_mobile/features/login/pages/main_login_page.dart';
import 'package:fisioflex_mobile/interceptors/http_auth_interceptor_service.dart';
import 'package:fisioflex_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return MaterialApp(
        darkTheme: AppThemeData.darkMode,
        theme: AppThemeData.lightMode,
        home: Scaffold(
            body: authState.isAuthenticated
                ? const BottomMenu()
                : const MainLoginPage()));
  }
}

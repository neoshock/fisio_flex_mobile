import 'package:fisioflex_mobile/config/theme.dart';
import 'package:fisioflex_mobile/core/auth/providers/auth_provider.dart';
import 'package:fisioflex_mobile/features/login/pages/main_login_page.dart';
import 'package:fisioflex_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: AppThemeData.darkMode,
        theme: AppThemeData.lightMode,
        home: Scaffold(
            body: authState.isAuthenticated
                ? const BottomMenu()
                : const MainLoginPage()));
  }
}

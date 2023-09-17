import 'package:fisioflex_mobile/config/theme.dart';
import 'package:fisioflex_mobile/core/auth/providers/auth_provider.dart';
import 'package:fisioflex_mobile/features/login/pages/main_login_page.dart';
import 'package:fisioflex_mobile/widgets/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation
        .portraitUp, // Para que la orientación predeterminada sea vertical
    DeviceOrientation
        .landscapeLeft, // Para habilitar el modo apaisado a la izquierda
    DeviceOrientation
        .landscapeRight, // Para habilitar el modo apaisado a la derecha
  ]);
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

import 'package:fisioflex_mobile/config/theme.dart';
import 'package:fisioflex_mobile/features/login/pages/main_login_page.dart';
import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: AppThemeData.darkMode,
        theme: AppThemeData.lightMode,
        home: Scaffold(body: MainLoginPage()));
  }
}

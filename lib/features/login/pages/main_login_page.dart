import 'package:fisioflex_mobile/features/login/pages/login__header_title.dart';
import 'package:fisioflex_mobile/features/login/pages/login_footer.dart';
import 'package:fisioflex_mobile/features/login/pages/login_form.dart';
import 'package:fisioflex_mobile/features/login/pages/login_header.dart';
import 'package:flutter/material.dart';

class MainLoginPage extends StatelessWidget {
  const MainLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //image
        LoginHeader(),
        LoginHeaderTitle(),
        //forms
        LoginForm(),
        //LoginFooter()
        //other logins
      ],
    );
  }
}

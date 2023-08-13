import 'package:fisioflex_mobile/widgets/bottom_menu.dart';
import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:fisioflex_mobile/widgets/image_animation.dart';
import 'package:fisioflex_mobile/widgets/move_animations.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        child: Form(
            child: Column(
          children: [
            MoveToLeftAnimation(
              timeDelay: 150,
              widget: textInputWidget('User Name', TextEditingController(),
                  TextInputType.emailAddress, false, const Icon(Icons.person)),
            ),
            MoveToRightAnimation(
              timeDelay: 300,
              widget: textInputWidget('Password', TextEditingController(),
                  TextInputType.visiblePassword, true, const Icon(Icons.lock)),
            ),
            ImageAnimation(
                widget: buttonSubmitWidget('Login', () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const BottomMenu(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: animation.drive(Tween(begin: 0.0, end: 1.0)
                          .chain(CurveTween(curve: Curves.easeInOut))),
                      child: child,
                    );
                  },
                  transitionDuration:
                      const Duration(milliseconds: 500), // Ajusta a tu gusto
                ),
              );
            }, context))
          ],
        )));
  }
}

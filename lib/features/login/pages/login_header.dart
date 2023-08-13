import 'package:fisioflex_mobile/widgets/image_animation.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  Widget imageIconWidget(String image_url) {
    return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(image_url), fit: BoxFit.cover),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.39,
        ),
        ClipPath(
            clipper: _LoginHeaderClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.36,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Theme.of(context).colorScheme.primary,
                    Colors.blueAccent
                  ])),
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: ImageAnimationRotate(
              widget: imageIconWidget('assets/icons/dumbbell.png'),
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.24,
            left: MediaQuery.of(context).size.width * 0.7,
            child: ImageAnimation(
                widget: imageIconWidget('assets/icons/remote-control.png')))
      ],
    );
  }
}

class _LoginHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;

    path.lineTo(0, height * 0.8);
    path.quadraticBezierTo(width * 0.25, height, width * 0.5, height);
    path.quadraticBezierTo(width * 0.75, height, width, height * 0.8);
    path.lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(_LoginHeaderClipper oldClipper) => false;
}

import 'package:flutter/material.dart';

class BezierCurve extends CustomClipper<Path> {
  final double controlPoint;

  BezierCurve({required this.controlPoint});

  @override
  Path getClip(Size size) {
    final path = Path();
    final height = size.height;
    final width = size.width;

    path.moveTo(0, height * 0.5);
    path.quadraticBezierTo(
        width * controlPoint, height * 0.8, width, height * 0.5);
    path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

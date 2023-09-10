import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class ImageAnimation extends StatefulWidget {
  final Widget widget;
  const ImageAnimation({Key? key, required this.widget}) : super(key: key);

  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _offsetAnimation = Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.widget,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ImageAnimationRotate extends StatefulWidget {
  final Widget widget;
  const ImageAnimationRotate({Key? key, required this.widget})
      : super(key: key);

  @override
  _ImageAnimationRotateState createState() => _ImageAnimationRotateState();
}

class _ImageAnimationRotateState extends State<ImageAnimationRotate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Path _path = Path();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _path.moveTo(0, 0); // Punto de inicio
    _path.quadraticBezierTo(50, -100, 100, 0); // Curva cuadrática

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final metrics = _path.computeMetrics().first;
        final value =
            metrics.getTangentForOffset(_animation.value * metrics.length);
        if (value != null) {
          return Transform.translate(
            offset: Offset(value.position.dx, value.position.dy),
            child: widget.widget,
          );
        } else {
          return widget.widget;
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimateOpacityWidget extends StatefulWidget {
  final Widget widget;
  final int delay;

  const AnimateOpacityWidget({
    Key? key,
    required this.widget,
    required this.delay,
  }) : super(key: key);

  @override
  _AnimateOpacityWidgetState createState() => _AnimateOpacityWidgetState();
}

class _AnimateOpacityWidgetState extends State<AnimateOpacityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.widget,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

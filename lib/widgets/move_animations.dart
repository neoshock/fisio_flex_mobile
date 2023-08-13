import 'package:flutter/material.dart';

class MoveToLeftAnimation extends StatefulWidget {
  final Widget widget;
  final int timeDelay;
  const MoveToLeftAnimation(
      {Key? key, required this.widget, required this.timeDelay})
      : super(key: key);

  @override
  _MoveToLeftAnimationState createState() => _MoveToLeftAnimationState();
}

class _MoveToLeftAnimationState extends State<MoveToLeftAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900), // Duración total 2 segundos.
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1, 0), // Comienza desde la izquierda
      end: Offset(0, 0), // Termina en su posición original
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.timeDelay), () {
      // Retraso de 1 segundo antes de comenzar la animación
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.widget,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MoveToRightAnimation extends StatefulWidget {
  final Widget widget;
  final int timeDelay;
  const MoveToRightAnimation(
      {Key? key, required this.widget, required this.timeDelay})
      : super(key: key);

  @override
  _MoveToRightAnimationState createState() => _MoveToRightAnimationState();
}

class _MoveToRightAnimationState extends State<MoveToRightAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900), // Duración total 2 segundos.
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1, 0), // Comienza desde la derecha
      end: Offset(0, 0), // Termina en su posición original
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.timeDelay), () {
      // Retraso de 1 segundo antes de comenzar la animación
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.widget,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

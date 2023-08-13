import 'package:flutter/material.dart';

class GridItemHero extends StatelessWidget {
  final String tag;
  final Widget child;
  final VoidCallback onTap;

  GridItemHero({
    required this.tag,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}

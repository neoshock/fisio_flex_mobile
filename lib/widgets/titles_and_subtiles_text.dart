import 'package:flutter/material.dart';

Widget PageTitle(String title, IconData icon, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 30,
        color: Theme.of(context).colorScheme.secondary,
      ),
      const SizedBox(width: 6),
      Text(title, style: Theme.of(context).textTheme.displayLarge),
      const SizedBox(width: 6),
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      const SizedBox(width: 6),
    ],
  );
}

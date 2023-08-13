import 'package:flutter/material.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const MainTitleWidget({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
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
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }
}

import 'package:fisioflex_mobile/config/utils.dart';
import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text(getDateNow(), style: Theme.of(context).textTheme.bodySmall),
      subtitle: Text('Bienvenido de nuevo',
          style: Theme.of(context).textTheme.displayMedium),
      trailing: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/802009_man_512x512.png')),
    );
  }
}

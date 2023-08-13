import 'package:flutter/material.dart';

class LoginHeaderTitle extends StatelessWidget {
  const LoginHeaderTitle({Key? key}) : super(key: key);

  Widget titleText(String title, BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.displayLarge);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            titleText('Fixioflex Login', context),
          ],
        ));
  }
}

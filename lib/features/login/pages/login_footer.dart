import 'package:fisioflex_mobile/widgets/image_animation.dart';
import 'package:fisioflex_mobile/widgets/move_animations.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MoveToRightAnimation(
            timeDelay: 150,
            widget: TextButton(
                onPressed: () {},
                child: Text('Forgot Password?',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.end)),
          ),
          Row(
            children: [
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('OR', style: Theme.of(context).textTheme.bodySmall),
              ),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              )),
            ],
          ),
          ImageAnimation(
            widget: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_alt_outlined,
                        color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: 9),
                    Text(
                      'Register',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

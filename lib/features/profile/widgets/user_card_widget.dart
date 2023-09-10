import 'package:fisioflex_mobile/core/auth/models/user_model.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final UserModel userModel;
  const UserCardWidget({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage:
              const AssetImage('assets/images/802009_man_512x512.png'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  userModel.firstName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  userModel.lastName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Identificacion: ${userModel.docNumber}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Telefono: ${userModel.phone}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

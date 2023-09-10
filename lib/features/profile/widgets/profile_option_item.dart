import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  const ProfileOptionItem(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => onTap(),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

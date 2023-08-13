import 'package:flutter/material.dart';

class HomeSumaryContainer extends StatelessWidget {
  const HomeSumaryContainer({Key? key}) : super(key: key);

  Widget _summaryItem(
      BuildContext context, Icon icon, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem(
              context,
              Icon(
                Icons.task_alt_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
              '23',
              'Complete'),
          _summaryItem(
              context,
              Icon(
                Icons.timelapse_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              '1.4',
              'Hours'),
          _summaryItem(
              context,
              Icon(
                Icons.meeting_room_outlined,
                size: 36,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              '+4',
              'Sessions'),
        ],
      ),
    );
  }
}

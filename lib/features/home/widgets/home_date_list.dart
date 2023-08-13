import 'package:flutter/material.dart';

class HomeDateList extends StatelessWidget {
  const HomeDateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _dateItem(context),
        itemCount: 10,
      ),
    );
  }

  Widget _dateItem(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Thu', style: Theme.of(context).textTheme.bodySmall),
          Text('22', style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
    );
  }
}

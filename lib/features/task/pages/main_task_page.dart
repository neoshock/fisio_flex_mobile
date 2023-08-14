import 'package:fisioflex_mobile/features/task/pages/main_task_detail.dart';
import 'package:fisioflex_mobile/features/task/widgets/grid_item_hero.dart';
import 'package:fisioflex_mobile/widgets/image_animation.dart';
import 'package:fisioflex_mobile/widgets/move_animations.dart';
import 'package:flutter/material.dart';
import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:fisioflex_mobile/widgets/titles_and_subtiles_text.dart';

class MainTaskPage extends StatelessWidget {
  MainTaskPage({Key? key}) : super(key: key);

  final List<String> status = ['Pedding', 'Complete', 'Favorites'];
  final int _value = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60),
          PageTitle('Tasks', Icons.check_circle, context),
          const SizedBox(height: 15),
          _buildTextInput(context),
          const SizedBox(height: 15),
          _buildChoiceChips(context),
          const SizedBox(height: 15),
          _buildGridView(context),
          const SizedBox(height: 90),
        ],
      ),
    );
  }

  Widget _buildTextInput(BuildContext context) {
    return textInputtWithoutlabel(
      'Search...',
      TextEditingController(),
      TextInputType.text,
      false,
      const Icon(Icons.search),
      (p0) {},
    );
  }

  Widget _buildChoiceChips(BuildContext context) {
    return Wrap(
      spacing: 15.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(
          status.length,
          (int index) => MoveToLeftAnimation(
                widget: _buildChoiceChip(context, index),
                timeDelay: index * 300,
              )),
    );
  }

  Widget _buildChoiceChip(BuildContext context, int index) {
    return ChoiceChip(
      label: Text(
        status[index],
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(6),
      selected: _value == index,
      avatar: Icon(Icons.check_circle,
          color: _value == index
              ? const Color.fromARGB(255, 45, 211, 111)
              : const Color.fromARGB(255, 255, 255, 255)),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 1,
            color: _value == index
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(15),
      ),
      onSelected: (bool selected) {},
    );
  }

  Widget _buildGridView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index < 6) {
              return AnimateOpacityWidget(
                  widget: GridItemHero(
                    tag: 'taskDetail$index',
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600), // Duración
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: MainTaskDetail(index: index),
                                    ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve =
                                  Curves.easeInOut; // Curva personalizada
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            }),
                      );
                    },
                    child: _buildGridItem(context),
                  ),
                  delay: index * 100);
            } else {
              return _buildGridItem(context);
            }
          }),
    );
  }

  Widget _buildGridItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            height: 69,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 90,
                    height: 30,
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 16, 191, 98),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Complete',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ))),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.favorite_border_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Title',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text(
                        '10 Minutes',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

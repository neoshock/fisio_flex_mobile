import 'package:fisioflex_mobile/features/task/models/task_model.dart';
import 'package:fisioflex_mobile/features/task/pages/main_task_detail.dart';
import 'package:fisioflex_mobile/features/task/providers/task_provider.dart';
import 'package:fisioflex_mobile/features/task/widgets/grid_item_hero.dart';
import 'package:flutter/material.dart';
import 'package:fisioflex_mobile/widgets/forms_inputs.dart';
import 'package:fisioflex_mobile/widgets/titles_and_subtiles_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainTaskPage extends StatefulHookConsumerWidget {
  const MainTaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTaskPageState();
}

class _MainTaskPageState extends ConsumerState<MainTaskPage> {
  final List<String> status = ['Pendientes', 'Completadas'];

  Widget _buildTextInput(BuildContext context) {
    return textInputtWithoutlabel(
      'Buscar...',
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
        (int index) => _buildChoiceChip(context, index),
      ),
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
      selected: ref.watch(taskProvider.notifier).status == index,
      avatar: Icon(Icons.check_circle,
          color: ref.watch(taskProvider.notifier).status == index
              ? const Color.fromARGB(255, 45, 211, 111)
              : const Color.fromARGB(255, 255, 255, 255)),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 1,
            color: ref.watch(taskProvider.notifier).status == index
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(15),
      ),
      onSelected: (bool selected) {
        ref.read(taskProvider.notifier).setStatus(index);
      },
    );
  }

  Widget _buildGridView(BuildContext context, List<TaskModel> task) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: task.length,
          itemBuilder: (context, index) {
            if (index < 6) {
              return GridItemHero(
                tag: 'taskDetail$index',
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        transitionDuration:
                            const Duration(milliseconds: 600), // Duración
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                              opacity: animation,
                              child: MainTaskDetail(
                                taskId: task[index].id,
                                taskStatus: task[index].isCompleted,
                              ),
                            ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut; // Curva personalizada
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        }),
                  );
                },
                child: _buildGridItem(context, task[index]),
              );
            } else {
              return _buildGridItem(context, task[index]);
            }
          }),
    );
  }

  Widget _buildGridItem(BuildContext context, TaskModel taskModel) {
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
              color: Theme.of(context).colorScheme.primary,
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
                      color: taskModel.isCompleted
                          ? Colors.green
                          : Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                        taskModel.isCompleted ? 'Completada' : 'Pendiente',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ))),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: taskModel.isCompleted
                        ? const Color.fromARGB(255, 45, 211, 111)
                        : Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.check_circle_outline),
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
                    taskModel.task.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text(
                        '${taskModel.task.estimatedTime.toString()} Minutos',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60),
          PageTitle('Tareas', Icons.check_circle, context),
          const SizedBox(height: 15),
          _buildTextInput(context),
          const SizedBox(height: 15),
          _buildChoiceChips(context),
          const SizedBox(height: 15),
          FutureBuilder(
              future: ref.read(taskProvider.notifier).getTasks(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return _buildGridView(context, snapshot.data);
                  } else {
                    return const Center(
                      child: Text('No hay datos'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

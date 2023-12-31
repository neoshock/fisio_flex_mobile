import 'package:fisioflex_mobile/features/task/models/task_detail_model.dart';
import 'package:fisioflex_mobile/features/task/models/task_log_model.dart';
import 'package:fisioflex_mobile/features/task/pages/main_task_video.dart';
import 'package:fisioflex_mobile/features/task/providers/task_provider.dart';
import 'package:fisioflex_mobile/features/task/repositories/task_log_repository.dart';
import 'package:fisioflex_mobile/features/task/widgets/bezier_curve_box.dart';
import 'package:fisioflex_mobile/features/task/widgets/cronometer_dialog_widget.dart';
import 'package:fisioflex_mobile/features/task/widgets/grid_item_hero.dart';
import 'package:fisioflex_mobile/widgets/main_title_widget.dart';
import 'package:fisioflex_mobile/widgets/succes_dialog_widget.dart';
import 'package:fisioflex_mobile/widgets/warning_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MainTaskDetail extends StatefulHookConsumerWidget {
  final int taskId;
  const MainTaskDetail({Key? key, required this.taskId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTaskDetailState();
}

class _MainTaskDetailState extends ConsumerState<MainTaskDetail> {
  final ValueNotifier<bool> _showBlur = ValueNotifier<bool>(true);
  bool isCompletedTask = false;
  FlutterTts flutterTts = FlutterTts();
  final TaskLogRepository _taskLogRepository =
      TaskLogRepository(); // Crea una instancia del repositorio

  @override
  void initState() {
    ref.read(taskProvider.notifier).getTaskById(widget.taskId).then((value) {
      final task = value.data as TaskDetailModel;
      isCompletedTask = task.isCompleted;
    });
    initTts();
    super.initState();
  }

  void initTts() async {
    await flutterTts.setLanguage("es-MX");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
  }

  void startSpeech(String text) async {
    await flutterTts.speak(text);
  }

  void _startTimerAndSaveLog() {
    // Inicia el cronómetro
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CronometerWidget(
          onComplete: (int seconds) async {
            // Cuando se completa el cronómetro, crea un TaskLog y guárdalo
            final taskLog = TaskLogModel(widget.taskId, [
              TimeEntryModel(
                  DateTime.now(),
                  DateTime.now().add(Duration(
                      seconds:
                          seconds))), // Puedes agregar más entradas aquí si es necesario
            ]);
            await _taskLogRepository.saveTaskLog(taskLog);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    flutterTts.setSharedInstance(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
        body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels > 0 && _showBlur.value) {
                _showBlur.value = false;
              } else if (notification.metrics.pixels <= 0 && !_showBlur.value) {
                _showBlur.value = true;
              }
              return false; // Propagation of the scroll notification
            },
            child: FutureBuilder(
              future:
                  ref.read(taskProvider.notifier).getTaskById(widget.taskId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final task = snapshot.data.data as TaskDetailModel;
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: GridItemHero(
                                tag: 'taskDetail${widget.taskId}',
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    ClipPath(
                                      clipper: BezierCurve(controlPoint: 0.24),
                                      child: Container(
                                        width: screenSize.width,
                                        height: screenSize.height * 0.69,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                    _buildPositionedMic(
                                        screenSize, theme, task),
                                    _buildReturnButtom(context),
                                    _buildPositionedIcon(screenSize, theme,
                                        isCompletedTask, task.assignmentId),
                                    _buildCronometerButton(screenSize, theme),
                                    _buildPositionedCompleteContainer(
                                        screenSize, theme, isCompletedTask),
                                    _buildPositionedTitle(
                                        screenSize, theme, task.title),
                                    Positioned(
                                      top: screenSize.height * 0.49,
                                      left: screenSize.width * 0.045,
                                      child: MainTitleWidget(
                                        title: 'Creado',
                                        subtitle: task.createdAt,
                                      ),
                                    ),
                                    _buildPositionedText(
                                        screenSize, theme, task.description),
                                  ],
                                )),
                          ),
                        ),
                        SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: true,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _showBlur,
                            builder: (context, showBlur, child) => Stack(
                              children: [
                                task.files.isNotEmpty
                                    ? task.files[0].type != 'mp4'
                                        ? StoriesScreen(stories: task.files)
                                        : Center(child: Text('No hay videos'))
                                    : Container(
                                        child: Center(
                                            child: Text('No hay videos')),
                                      ),
                                // Sólo muestra el blur cuando showBlur es verdadero
                                if (showBlur) ...[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .background,
                                          Theme.of(context)
                                              .colorScheme
                                              .background
                                              .withOpacity(0.3),
                                          Colors.transparent,
                                          Colors.black.withOpacity(
                                              0.4), // Opacidad en la parte inferior
                                        ],
                                        stops: const [
                                          0.1,
                                          0.6,
                                          0.95,
                                          1.0,
                                        ], // Define dónde comienza y termina cada color en el degradado
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )));
  }

  Positioned _buildReturnButtom(BuildContext context) {
    return Positioned(
        top: 60,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15)),
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.background,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ));
  }

  Positioned _buildCronometerButton(Size screenSize, ThemeData theme) {
    return Positioned(
      bottom: screenSize.height * 0.24,
      left: screenSize.width * 0.42,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape
              .circle, // Si no se define, se toma como BoxShape.rectangle
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: IconButton(
            splashRadius: 60, // Tamaño del área de efecto al presionar el botón
            splashColor:
                theme.colorScheme.background.withOpacity(0.3), // Color del área
            padding: EdgeInsets.zero,
            onPressed: () {
              _startTimerAndSaveLog();
            },
            icon: const Icon(
              Icons.timer,
              size: 45,
              color: Colors.white,
            )),
      ),
    );
  }

  Positioned _buildPositionedIcon(
      Size screenSize, ThemeData theme, bool isCompleted, int assigmentId) {
    return Positioned(
      bottom: screenSize.height * 0.24,
      right: screenSize.width * 0.1,
      child: ElevatedButton(
        onPressed: () {
          if (!isCompleted) {
            ref
                .read(taskProvider.notifier)
                .updateTask(assigmentId)
                .then((value) {
              if (value.statusCode != 200) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => WarningDialogWidget(
                          title: '¡Hubo un problema!',
                          description: value.statusMessage!,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ));
              } else {
                setState(() {
                  isCompletedTask = true;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SuccesDialogWidget(
                          title: '¡Tarea completada!',
                          description: value.statusMessage!,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ));
              }
            });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) => WarningDialogWidget(
                      title: '¡Tarea ya completada!',
                      description: 'Esta tarea ya ha sido completada',
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ));
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: isCompleted
              ? const Color.fromARGB(255, 45, 211, 111)
              : theme.colorScheme.onSurface,
          padding: const EdgeInsets.all(20),
          elevation: 10,
        ),
        child: Icon(
          Icons.check_circle_outline,
          size: 45,
          color: isCompleted ? theme.colorScheme.background : Colors.white,
        ),
      ),
    );
  }

  Positioned _buildPositionedCompleteContainer(
      Size screenSize, ThemeData theme, bool isComplete) {
    return Positioned(
      top: screenSize.height * 0.24,
      left: screenSize.width * 0.1,
      child: Container(
        decoration: BoxDecoration(
          color: isComplete
              ? const Color.fromARGB(255, 45, 211, 111)
              : theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          isComplete ? 'Completada' : 'Pendiente',
          style: theme.textTheme.displayMedium!.copyWith(
            color: theme.colorScheme.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Positioned _buildPositionedTitle(
      Size screenSize, ThemeData theme, String title) {
    return Positioned(
      top: screenSize.height * 0.15,
      left: screenSize.width * 0.1,
      child: SizedBox(
        width: screenSize.width * 0.8,
        child: Text(
          title,
          maxLines: 2,
          style: theme.textTheme.displayLarge!.copyWith(
            color: theme.colorScheme.background,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Positioned _buildPositionedMic(
      Size screenSize, ThemeData theme, TaskDetailModel taskDetailModel) {
    return Positioned(
      top: 60,
      left: screenSize.width * 0.4,
      child: SizedBox(
        width: screenSize.width,
        child: IconButton(
          splashRadius: 60, // Tamaño del área de efecto al presionar el botón
          splashColor:
              theme.colorScheme.background.withOpacity(0.3), // Color del área
          onPressed: () {
            String text =
                'Tienes que hacer, ${taskDetailModel.title}, consiste en ${taskDetailModel.description}, esta tarea fue creada el ${taskDetailModel.createdAt}';
            startSpeech(text);
          },
          icon: const Icon(
            Icons.campaign,
            size: 45,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Positioned _buildPositionedText(
      Size screenSize, ThemeData theme, String description) {
    return Positioned(
      top: screenSize.height * 0.53,
      left: screenSize.width * 0.045,
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Text(
          description,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          textAlign: TextAlign.justify,
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}

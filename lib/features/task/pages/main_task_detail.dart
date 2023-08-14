import 'dart:typed_data';
import 'dart:ui';

import 'package:fisioflex_mobile/features/task/pages/main_task_video.dart';
import 'package:fisioflex_mobile/features/task/widgets/bezier_curve_box.dart';
import 'package:fisioflex_mobile/features/task/widgets/grid_item_hero.dart';
import 'package:fisioflex_mobile/widgets/main_title_widget.dart';
import 'package:flutter/material.dart';

class MainTaskDetail extends StatefulWidget {
  final int index;
  const MainTaskDetail({Key? key, required this.index}) : super(key: key);

  @override
  _MainTaskDetailState createState() => _MainTaskDetailState();
}

class _MainTaskDetailState extends State<MainTaskDetail> {
  final ValueNotifier<bool> _showBlur = ValueNotifier<bool>(true);
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.topLeft,
              child: GridItemHero(
                  tag: 'taskDetail${widget.index}',
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
                      _buildReturnButtom(context),
                      _buildPositionedIcon(screenSize, theme),
                      _buildPositionedCompleteContainer(screenSize, theme),
                      _buildPositionedTitle(screenSize, theme),
                      Positioned(
                        top: screenSize.height * 0.49,
                        left: screenSize.width * 0.045,
                        child: const MainTitleWidget(
                          title: 'Content',
                          subtitle: '15/08/2023',
                        ),
                      ),
                      _buildPositionedText(screenSize, theme),
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
                  StoriesScreen(),

                  // Sólo muestra el blur cuando showBlur es verdadero
                  if (showBlur) ...[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).colorScheme.background,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.background,
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.3),
                            Colors.transparent,
                            Colors.black.withOpacity(
                                0.4), // Opacidad en la parte inferior
                          ],
                          stops: const [
                            0.2,
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
      ),
    ));
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

  Positioned _buildPositionedIcon(Size screenSize, ThemeData theme) {
    return Positioned(
      bottom: screenSize.height * 0.24,
      right: screenSize.width * 0.1,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: theme.colorScheme.primaryContainer,
          padding: const EdgeInsets.all(20),
          elevation: 10,
        ),
        child: Icon(
          Icons.favorite_border_outlined,
          size: 45,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }

  Positioned _buildPositionedCompleteContainer(
      Size screenSize, ThemeData theme) {
    return Positioned(
      top: screenSize.height * 0.24,
      left: screenSize.width * 0.1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 211, 111),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          'Complete',
          style: theme.textTheme.displayMedium!.copyWith(
            color: theme.colorScheme.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Positioned _buildPositionedTitle(Size screenSize, ThemeData theme) {
    return Positioned(
      top: screenSize.height * 0.15,
      left: screenSize.width * 0.1,
      child: SizedBox(
        width: screenSize.width * 0.8,
        child: Text(
          'Main Title Exercise',
          style: theme.textTheme.displayLarge!.copyWith(
            color: theme.colorScheme.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Positioned _buildPositionedText(Size screenSize, ThemeData theme) {
    return Positioned(
      top: screenSize.height * 0.53,
      left: screenSize.width * 0.045,
      child: SizedBox(
        width: screenSize.width * 0.9,
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque scelerisque non est non cursus. Etiam non risus id mi fermentum laoreet vel eu orci.',
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          textAlign: TextAlign.justify,
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}

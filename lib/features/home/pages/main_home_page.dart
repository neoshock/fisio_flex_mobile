import 'dart:math';

import 'package:fisioflex_mobile/config/utils.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_date_list.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_header_widget.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_stats_container.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_sumary_container.dart';
import 'package:fisioflex_mobile/widgets/main_title_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool _showShadow = false;

  late List<FlSpot> _randomData = [];
  int randomNumber = 0;
  double randomHours = 0;
  int selectedDayIndex = 0;

  final random = Random();

  void handleItemSelected(int index) {
    setState(() {
      selectedDayIndex = index;
    });
    randomize();
  }

  @override
  void initState() {
    randomize();
    super.initState();
  }

  void randomize() {
    _randomData.clear();
    randomNumber = Random().nextInt(120);
    randomHours = Random().nextDouble() * 2.1;

    for (int i = 1; i <= 7; i++) {
      final x = i.toDouble();
      final y =
          random.nextDouble() * 3 + 1; // Genera números aleatorios entre 1 y 4.
      _randomData.add(FlSpot(x, y));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels > 0 && !_showShadow) {
                setState(() {
                  _showShadow = true;
                });
              } else if (scrollNotification.metrics.pixels <= 0 &&
                  _showShadow) {
                setState(() {
                  _showShadow = false;
                });
              }
              return true;
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 45),
                  const SizedBox(height: 30),
                  HomeDateList(
                    onItemSelected: handleItemSelected,
                  ),
                  const SizedBox(height: 30),
                  MainTitleWidget(
                      title: 'Ultima semana', subtitle: getDateNow()),
                  const SizedBox(height: 30),
                  HomeSumaryContainer(totalHours: randomHours),
                  const SizedBox(height: 30),
                  MainTitleWidget(
                      title: 'Resultados recientes', subtitle: getDateNow()),
                  const SizedBox(height: 30),
                  HomeStatsContainer(
                    randomData: _randomData,
                    randomNumber: randomNumber,
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: _showShadow
                  ? [
                      const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0.0, 0.75))
                    ]
                  : [],
            ),
            child: const HomeHeaderWidget(),
          ),
        ),
      ],
    );
  }
}

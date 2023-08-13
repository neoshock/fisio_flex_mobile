import 'package:fisioflex_mobile/features/home/widgets/home_date_list.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_header_widget.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_stats_container.dart';
import 'package:fisioflex_mobile/features/home/widgets/home_sumary_container.dart';
import 'package:fisioflex_mobile/widgets/image_animation.dart';
import 'package:fisioflex_mobile/widgets/main_title_widget.dart';
import 'package:fisioflex_mobile/widgets/move_animations.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool _showShadow = false;

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
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 45),
                  SizedBox(height: 30),
                  ImageAnimation(
                    widget: HomeDateList(),
                  ),
                  SizedBox(height: 30),
                  MoveToLeftAnimation(
                      widget: MainTitleWidget(
                          title: 'Last Week', subtitle: '15/08/2023'),
                      timeDelay: 150),
                  SizedBox(height: 30),
                  MoveToRightAnimation(
                      widget: HomeSumaryContainer(), timeDelay: 300),
                  SizedBox(height: 30),
                  MoveToLeftAnimation(
                      widget: MainTitleWidget(
                          title: 'Last Month', subtitle: '15/08/2023'),
                      timeDelay: 450),
                  SizedBox(height: 30),
                  MoveToRightAnimation(
                      widget: HomeStatsContainer(), timeDelay: 600),
                  SizedBox(height: 90),
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

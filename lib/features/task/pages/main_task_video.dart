import 'dart:async';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late List<String> _stories;
  late List<AnimationController> _progressControllers;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stories = ['assets/images/example1.png', 'assets/images/example.webp'];

    _pageController = PageController(initialPage: _currentPage);

    _progressControllers = List.generate(
      _stories.length,
      (index) =>
          AnimationController(vsync: this, duration: Duration(seconds: 15))
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed &&
                  _currentPage < _stories.length - 1) {
                _currentPage++;
                _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
            })
            ..addListener(() {
              setState(
                  () {}); // Esto provocará que el widget se reconstruya cada vez que cambie el valor del AnimationController.
            }),
    );
    _startProgress();
  }

  void _startProgress() {
    _progressControllers[_currentPage].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: _stories.length,
            onPageChanged: (value) {
              _currentPage = value;
              _progressControllers.forEach((controller) => controller.stop());
              _progressControllers[_currentPage].reset();
              _startProgress();
            },
            itemBuilder: (context, index) =>
                _buildStoryPage(context, _stories[index]),
          ),
          Positioned(
            top: 69.0,
            left: 10.0,
            right: 10.0,
            child: Row(
              children: _buildIndicators(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < _stories.length; i++) {
      indicators.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: LinearProgressIndicator(
              value: i == _currentPage
                  ? _progressControllers[i].value
                  : (i < _currentPage ? 1.0 : 0.0),
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );
    }
    return indicators;
  }

  Widget _buildStoryPage(BuildContext context, String imagePath) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(15.0)), // 1
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

import 'dart:async';
import 'package:fisioflex_mobile/features/task/models/task_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StoriesScreen extends StatefulWidget {
  final List<FileElement> stories;

  const StoriesScreen({Key? key, required this.stories}) : super(key: key);

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
  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.stories.first.url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    _progressControllers = List.generate(
        widget.stories.length,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(seconds: 5),
            ));
    _pageController = PageController(initialPage: _currentPage, keepPage: true);
    //_startProgress();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void _startProgress() {
    _progressControllers[_currentPage].forward();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
        builder: (context, player) {
          return Center(
            child: Container(child: player),
          );
        });
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

  Widget _buildVideoStory(BuildContext context, String videoUrl) {
    final controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blue,
      ),
    );
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
    _controller.dispose();
    super.dispose();
  }
}

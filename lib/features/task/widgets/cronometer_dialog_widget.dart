import 'dart:async';
import 'package:flutter/material.dart';

class CronometerWidget extends StatefulWidget {
  final Function(int seconds) onComplete; // Agrega este campo

  const CronometerWidget({Key? key, required this.onComplete})
      : super(key: key);

  @override
  _CronometerWidgetState createState() => _CronometerWidgetState();
}

class _CronometerWidgetState extends State<CronometerWidget> {
  int seconds = 0;
  bool isRunning = false;
  late Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) {});

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;
      });
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
    });

    if (_timer.isActive) {
      _timer.cancel(); // Detén el temporizador si está activo
    }
  }

  void resetTimer() {
    setState(() {
      seconds = 0;
      isRunning = false;
    });

    if (_timer.isActive) {
      _timer.cancel(); // Detén el temporizador si está activo
    }
  }

  Widget _buildButtonStartStop() {
    return Container(
      decoration: BoxDecoration(
        color: isRunning ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          if (isRunning) {
            stopTimer();
          } else {
            startTimer();
          }
        },
        icon: Icon(
          isRunning ? Icons.stop : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRestarButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isRunning ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          resetTimer();
        },
        icon: const Icon(
          Icons.restore,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextScren(String time) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildMainHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Cronómetro',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 24),
        _buildFinishedButton(context)
      ],
    );
  }

  Widget _buildFinishedButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          widget.onComplete(seconds);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Asegúrate de detener el temporizador cuando el widget se destruye
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = _formatTime(seconds);

    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildMainHeader(context),
                const SizedBox(height: 30),
                _buildTextScren(formattedTime),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildButtonStartStop(),
                    const SizedBox(width: 24),
                    _buildRestarButton(
                      context,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  String _formatTime(int seconds) {
    final int minutes = (seconds / 60).floor();
    final int remainingSeconds = seconds % 60;
    final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}

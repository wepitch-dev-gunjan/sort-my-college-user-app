import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  TimeDisplayState createState() => TimeDisplayState();
}

class TimeDisplayState extends State<TimeDisplay> {
  final DateTime _currentTime = DateTime.now();
  late DateTime _twoHoursAhead;
  Duration _timerDuration = const Duration(hours: 2);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTwoHoursAhead();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTwoHoursAhead() {
    _twoHoursAhead = _currentTime.add(const Duration(hours: 2));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDuration.inSeconds > 0) {
          _timerDuration = _timerDuration - const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Display'),
      ),
      body: Center(
        child: CircularCountDownTimer(
          duration: _timerDuration.inSeconds,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          fillColor: Colors.blue.shade100,
          strokeWidth: 10.0,
          textStyle: const TextStyle(fontSize: 30.0, color: Colors.black45),
          isReverse: true,
          onComplete: () {
            print('Timer Completed');
          }, ringColor: Colors.blue,
        ),
      ),
    );
  }
}

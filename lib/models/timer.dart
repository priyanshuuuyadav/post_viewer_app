import 'dart:async';

class TimerData {
  final int id;
  int time;
  bool isRunning;
  Timer? timer;

  TimerData({required this.id, required this.time, this.isRunning = false, this.timer});
}
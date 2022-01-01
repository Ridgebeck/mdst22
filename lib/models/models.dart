import 'package:flutter/material.dart';

class Task {
  final IconData iconData;
  final String taskDescription;
  final Difficulty difficulty;
  final DateTime startTime;
  final Duration duration;
  bool isDone;

  Task({
    required this.iconData,
    required this.taskDescription,
    required this.difficulty,
    required this.startTime,
    required this.duration,
    required this.isDone,
  });
}

enum Difficulty {
  easy,
  medium,
  hard,
}

import 'package:flutter/material.dart';

class Task {
  final String categoryImg;
  final String taskDescription;
  final Difficulty difficulty;
  final DateTime startTime;
  final Duration duration;
  bool isDone;
  bool isActive;
  PolaroidFile? polaroid;

  Task({
    required this.categoryImg,
    required this.taskDescription,
    required this.difficulty,
    required this.startTime,
    required this.duration,
    required this.isDone,
    required this.isActive,
    this.polaroid,
  });
}

enum Difficulty {
  easy,
  medium,
  hard,
}

enum Filter {
  noFilter,
  sepium,
  greyScale,
  inverted,
}

class PolaroidFile {
  final String imagePath;
  final Filter filter;

  PolaroidFile({
    required this.imagePath,
    required this.filter,
  });
}

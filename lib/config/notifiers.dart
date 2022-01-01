import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/models.dart';

class TaskList extends ChangeNotifier {
  /// internal private state of the project list
  List<Task> _projectsList = [];

  /// internal method to sort list by isDone and start time
  _sort() {
    // sort by isDone
    _projectsList.sort((a, b) {
      return a.isDone ? -1 : 1;
    });
    // find index of last completed task
    int lastDoneTaskIdx = _projectsList.lastIndexWhere((element) => element.isDone);
    // find index of first open task
    int firstOpenTaskIdx = _projectsList.indexWhere((element) => !element.isDone);

    // sort completed tasks by start time
    if (lastDoneTaskIdx != -1) {
      _projectsList.setRange(
          0,
          lastDoneTaskIdx,
          _projectsList.sublist(0, lastDoneTaskIdx)
            ..sort((a, b) => a.startTime.compareTo(b.startTime)));
    }

    // sort open tasks by start time
    if (firstOpenTaskIdx != -1) {
      _projectsList.setRange(
          firstOpenTaskIdx,
          _projectsList.length,
          _projectsList.sublist(firstOpenTaskIdx, _projectsList.length)
            ..sort((a, b) => a.startTime.compareTo(b.startTime)));
    }
  }

  /// an unmodifiable view of the items in the list
  UnmodifiableListView<Task> get projectList => UnmodifiableListView(_projectsList);

  /// the current total number of tasks
  int get totalTasks => _projectsList.length;

  /// add new task to list
  void add(Task task) {
    _projectsList.add(task);
    _sort();
    // this will tell all widgets that are listening to update
    notifyListeners();
  }

  /// remove task from list
  void remove(Task task) {
    _projectsList.remove(task);
    _sort();
    // this will tell all widgets that are listening to update
    notifyListeners();
  }

  /// change isDone status to given bool
  void setDone({required int index, required bool value}) {
    _projectsList[index].isDone = value;
    _sort();
    // this will tell all widgets that are listening to update
    notifyListeners();
  }
}

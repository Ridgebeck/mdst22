import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mdst_22/config/notifiers.dart';
import 'package:mdst_22/screens/new_task_popup.dart';
import 'package:mdst_22/widgets/project_entry.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../config/my_doodle_icons.dart';
import '../models/models.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<ProjectEntry> convertList(UnmodifiableListView<Task> taskList) {
    return List<ProjectEntry>.generate(
      taskList.length,
      (index) => ProjectEntry(
        index: index,
        task: taskList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskList>(
      builder: (context, taskList, child) {
        List<ProjectEntry> projectsList = convertList(taskList.projectList);
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cork_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    ...projectsList,
                    const SizedBox(height: 75.0),
                  ],
                ),
              ),
              Positioned(
                bottom: 20.0,
                right: 20.0,
                child: FloatingActionButton(
                  elevation: 10.0,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const NewTaskPopUp(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/plus.png",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

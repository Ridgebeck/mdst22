import 'package:flutter/material.dart';
import 'package:mdst_22/models/models.dart';
import 'package:mdst_22/widgets/polaroid.dart';

class PolaroidScreen extends StatelessWidget {
  final Task task;
  const PolaroidScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Polaroid(
              // TODO: null check
              polaroid: task.polaroid!,
              title: "name of user",
              text: task.taskDescription,
            ),
          ),
        ),
      ),
    );
  }
}

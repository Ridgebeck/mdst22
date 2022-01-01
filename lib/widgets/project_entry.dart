import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/config/my_doodle_icons.dart';
import 'package:mdst_22/config/notifiers.dart';
import 'package:mdst_22/models/models.dart';
import 'package:provider/provider.dart';
import 'package:wired_elements/wired_elements.dart';

class ProjectEntry extends StatelessWidget {
  final int index;
  final IconData iconData;
  final String taskDescription;
  final Difficulty difficulty;
  final DateTime startTime;
  final Duration duration;
  final bool isDone;

  const ProjectEntry({
    required this.index,
    required this.iconData,
    required this.taskDescription,
    required this.difficulty,
    required this.startTime,
    required this.duration,
    required this.isDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardHeight = 6 / 13 * screenWidth;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: cardHeight * 1.15,
            child: ProgressLine(isDone: isDone),
          ),
        ),
        Expanded(
          flex: 10,
          child: TaskCard(
            index: index,
            iconData: iconData,
            height: cardHeight,
            isDone: isDone,
            difficulty: difficulty,
            duration: duration,
            startTime: startTime,
            text: taskDescription,
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  final bool isDone;

  const ProgressLine({
    required this.isDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: isDone ? const Icon(Icons.circle) : const Icon(Icons.circle_outlined),
        ),
        Expanded(
          child: Container(
            width: 2.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final int index;
  final double height;
  final IconData iconData;
  final String text;
  final Difficulty difficulty;
  final DateTime startTime;
  final Duration duration;
  final bool isDone;

  const TaskCard({
    required this.index,
    required this.height,
    required this.iconData,
    required this.text,
    required this.isDone,
    required this.difficulty,
    required this.startTime,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kTaskCardElevation,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: isDone ? Colors.grey : kKliemannsPink,
          //borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: AutoSizeText(
                          "#MDST22 - PROJEKT ${index + 1}",
                          style: GoogleFonts.permanentMarker(
                            fontSize: 20.0,
                            color: Colors.indigo[800],
                            decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: FittedBox(
                        child: Icon(
                          MyDoodleIcons.bulb,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: FittedBox(
                                      child: Icon(iconData),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      text,
                                      style: GoogleFonts.architectsDaughter(fontSize: 100.0),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: FittedBox(
                          child: Text(
                            "${DateFormat.Hm().format(startTime)} - "
                            "${DateFormat.Hm().format(startTime.add(duration))} Uhr",
                            style: GoogleFonts.architectsDaughter(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.all(2.0),
                          ),
                          onPressed: () {
                            isDone
                                ? Provider.of<TaskList>(context, listen: false).setDone(
                                    index: index,
                                    value: false,
                                  )
                                : Provider.of<TaskList>(context, listen: false).setDone(
                                    index: index,
                                    value: true,
                                  );
                          },
                          child: const WiredCard(child: Center(child: Text("FERTIG!"))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

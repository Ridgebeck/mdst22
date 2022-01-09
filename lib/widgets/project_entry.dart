import 'dart:ui';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/config/my_doodle_icons.dart';
import 'package:mdst_22/config/notifiers.dart';
import 'package:mdst_22/models/models.dart';
import 'package:mdst_22/screens/polaroid_detail_screen.dart';
import 'package:mdst_22/screens/take_picture_screen.dart';
import 'package:provider/provider.dart';
import 'package:wired_elements/wired_elements.dart';

import 'polaroid.dart';

class ProjectEntry extends StatelessWidget {
  final int index;
  final Task task;

  const ProjectEntry({
    required this.index,
    required this.task,
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
            child: ProgressLine(
              isDone: task.isDone,
              isActive: task.isActive,
              index: index,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: TaskCard(
            index: index,
            height: cardHeight,
            task: task,
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
  final bool isActive;
  final int index;

  const ProgressLine({
    required this.isDone,
    required this.isActive,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          isDone
              ? "assets/circle1_filled.png"
              : isActive
                  ? "assets/circle1_dot.png"
                  : "assets/circle1.png",
          height: 25.0,
          width: 25.0,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/" + kMarkerLines[index % kMarkerLines.length],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final int index;
  final double height;
  final Task task;

  const TaskCard({
    required this.index,
    required this.height,
    required this.task,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: task.isDone ? kTaskCardElevation / 2 : kTaskCardElevation,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/paper_bg.jpg"),
                fit: BoxFit.cover,
              ),
              //borderRadius: BorderRadius.circular(15),
            ),
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: task.isActive
                  ? Colors.green[200]!.withOpacity(0.6)
                  : Colors.pink[200]!.withOpacity(0.6),
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
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: GestureDetector(
                            onTap: () {
                              print("settings tapped");
                            },
                            child: FittedBox(
                              child: Image.asset(
                                "assets/gear.png",
                                width: 200.0,
                                height: 200.0,
                              ),
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
                                          child: Image.asset(
                                            "assets/" + task.categoryImg,
                                            width: 200.0,
                                            height: 200.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          task.taskDescription,
                                          style: GoogleFonts.architectsDaughter(
                                            fontSize: 100.0,
                                            color: task.isDone ? kKliemannsBlau : kKliemannsSchwarz,
                                          ),
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
                                "${DateFormat.Hm().format(task.startTime)} - "
                                "${DateFormat.Hm().format(task.startTime.add(task.duration))} Uhr",
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
                                // set isDone property of entry to true
                                task.isDone
                                    ? Provider.of<TaskList>(context, listen: false).setDone(
                                        index: index,
                                        value: false,
                                      )
                                    : Provider.of<TaskList>(context, listen: false).setDone(
                                        index: index,
                                        value: true,
                                      );

                                // take picture
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TakePicture(task: task)),
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
          task.isDone
              ? Positioned(
                  top: height / 2 - 20,
                  left: 50,
                  child: Transform.rotate(
                    angle: -pi / 6,
                    child: Icon(
                      MyDoodleIcons.erledigt_stamp,
                      color: Colors.green[800]!.withOpacity(0.9),
                      size: 100,
                    ),
                  ),
                )
              : Container(),
          // Positioned(
          //   left: 130,
          //   top: -7,
          //   child: Image.asset(
          //     "assets/thumb_tack.png",
          //     width: 32.0,
          //     height: 32.0,
          //   ),
          // ),
          task.isDone
              ? IgnorePointer(
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              : Container(),
          task.polaroid != null
              ? Positioned(
                  top: -3.0,
                  right: -3.0,
                  child: Transform.rotate(
                    angle: pi / 20,
                    child: SizedBox(
                      width: 130.0,
                      child: GestureDetector(
                        onTap: () {
                          print("tapped");
                          //Navigator.of(context).push(route);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (_, __, ___) => PolaroidScreen(task: task),
                            ),
                          );
                        },
                        child: Polaroid(
                          polaroid: task.polaroid!,
                          title: "name of user",
                          text: "picture title",
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

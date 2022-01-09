import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/widgets/feed_progress_post.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

List<_FinishedTasks> mockDataFynn = [
  _FinishedTasks(1, 10),
  _FinishedTasks(2, 15),
  _FinishedTasks(3, 20),
  _FinishedTasks(4, 22),
  _FinishedTasks(5, 35),
  _FinishedTasks(6, 40),
  _FinishedTasks(7, 47),
  _FinishedTasks(8, 53),
  _FinishedTasks(9, 54),
  _FinishedTasks(10, 55),
  _FinishedTasks(11, 71),
  _FinishedTasks(12, 77),
];

List<_FinishedTasks> mockDataBrian = [
  _FinishedTasks(1, 22),
  _FinishedTasks(2, 25),
  _FinishedTasks(3, 27),
  _FinishedTasks(4, 34),
  _FinishedTasks(5, 37),
  _FinishedTasks(6, 47),
  _FinishedTasks(7, 48),
  _FinishedTasks(8, 49),
  _FinishedTasks(9, 52),
  _FinishedTasks(10, 56),
  _FinishedTasks(11, 60),
  _FinishedTasks(12, 72),
];

List<_TasksByCategory> mockDataFynnCat = [
  _TasksByCategory("Kueche", 5),
  _TasksByCategory("Auto", 27),
  _TasksByCategory("Roller", 15),
  _TasksByCategory("Garten", 15),
];

List<_TasksByCategory> mockDataBrianCat = [
  _TasksByCategory("Kueche", 22),
  _TasksByCategory("Auto", 10),
  _TasksByCategory("Roller", 35),
  _TasksByCategory("Garten", 5),
];

final digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/cork_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 3,
                    child: PictureAndPoints(
                      picturePath: "sticker_brian.png",
                      teamTag: "#teambrian",
                      teamColor: kTeamBrian,
                      points: 1510,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "V",
                    style: GoogleFonts.permanentMarker(
                      fontSize: 80.0,
                      color: kTeamBrian,
                    ),
                  ),
                  Text(
                    "S",
                    style: GoogleFonts.permanentMarker(
                      fontSize: 80.0,
                      color: kTeamFynn,
                    ),
                  ),
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 3,
                    child: PictureAndPoints(
                      picturePath: "sticker_fynn.png",
                      teamTag: "#teamfynn",
                      teamColor: kTeamFynn,
                      points: 1380,
                    ),
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 20.0),
            //   child: ProgressBar(
            //     text: "noch 5 Stunden und 34 Minuten",
            //     percentage: 0.4,
            //   ),
            // ),
            Material(
              elevation: 10.0,
              color: Colors.grey[100],
              child: SfCartesianChart(
                title: ChartTitle(
                  text: "Punktestand",
                  textStyle: GoogleFonts.architectsDaughter(fontSize: 18.0),
                ),
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                    text: "Uhrzeit",
                    textStyle: GoogleFonts.architectsDaughter(fontSize: 18.0),
                  ),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: "Punkte",
                    textStyle: GoogleFonts.architectsDaughter(fontSize: 18.0),
                  ),
                ),
                //legend: Legend(isVisible: true),
                series: <LineSeries<_FinishedTasks, int>>[
                  LineSeries<_FinishedTasks, int>(
                    dataSource: mockDataFynn,
                    xValueMapper: (_FinishedTasks fTasks, _) => fTasks.hour,
                    yValueMapper: (_FinishedTasks fTasks, _) => fTasks.tasks,
                    width: 5.0,
                    color: kTeamFynn,
                    name: "Fynn",
                    isVisibleInLegend: true,
                  ),
                  LineSeries<_FinishedTasks, int>(
                    dataSource: mockDataBrian,
                    xValueMapper: (_FinishedTasks fTasks, _) => fTasks.hour,
                    yValueMapper: (_FinishedTasks fTasks, _) => fTasks.tasks,
                    width: 5.0,
                    color: kTeamBrian,
                    name: "Brian",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              color: Colors.grey[200],
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                //tooltipBehavior: _tooltip,
                series: <ChartSeries<_TasksByCategory, String>>[
                  BarSeries<_TasksByCategory, String>(
                    dataSource: mockDataFynnCat,
                    xValueMapper: (_TasksByCategory cTasks, _) => cTasks.category,
                    yValueMapper: (_TasksByCategory cTasks, _) => cTasks.tasks,
                    name: 'Gold',
                    color: kTeamFynn,
                  ),
                  BarSeries<_TasksByCategory, String>(
                    dataSource: mockDataBrianCat,
                    xValueMapper: (_TasksByCategory cTasks, _) => cTasks.category,
                    yValueMapper: (_TasksByCategory cTasks, _) => cTasks.tasks,
                    name: 'Gold',
                    color: kTeamBrian,
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}

class PictureAndPoints extends StatelessWidget {
  final String picturePath;
  final String teamTag;
  final Color teamColor;
  final int points;
  const PictureAndPoints({
    Key? key,
    required this.picturePath,
    required this.teamTag,
    required this.teamColor,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          teamTag,
          style: GoogleFonts.architectsDaughter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: teamColor,
          ),
        ),
        SizedBox(
          height: 100,
          child: Image.asset("assets/" + picturePath),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AutoSizeText(
            points.toString(),
            style: GoogleFonts.architectsDaughter(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: teamColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _FinishedTasks {
  final int hour;
  final double tasks;
  _FinishedTasks(
    this.hour,
    this.tasks,
  );
}

class _TasksByCategory {
  final String category;
  final double tasks;
  _TasksByCategory(
    this.category,
    this.tasks,
  );
}

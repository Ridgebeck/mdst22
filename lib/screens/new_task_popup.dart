import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/config/my_doodle_icons.dart';
import 'package:mdst_22/config/notifiers.dart';
import 'package:provider/provider.dart';
import 'package:wired_elements/wired_elements.dart';

import '../models/models.dart';

class NewTaskPopUp extends StatefulWidget {
  const NewTaskPopUp({Key? key}) : super(key: key);

  @override
  State<NewTaskPopUp> createState() => _NewTaskPopUpState();
}

List<IconData> iconDataList = const [
  MyDoodleIcons.clean,
  MyDoodleIcons.house,
  MyDoodleIcons.scooter,
  MyDoodleIcons.bulb,
  MyDoodleIcons.robot,
  MyDoodleIcons.whisk,
  MyDoodleIcons.shower,
  MyDoodleIcons.shirt,
  MyDoodleIcons.tool,
  MyDoodleIcons.laptop,
  MyDoodleIcons.flowers,
  MyDoodleIcons.welding,
];

class _NewTaskPopUpState extends State<NewTaskPopUp> {
  int _pageIndex = 1;
  late IconData _selectedIconData;

  // move to next page
  void increasePageIndex(IconData data) {
    setState(() {
      _selectedIconData = data;
      _pageIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          kDialogPadding,
          MediaQuery.of(context).padding.top + kAppBarHeight + kDialogPadding,
          kDialogPadding,
          MediaQuery.of(context).padding.bottom + kTabBarHeight + kDialogPadding,
        ),
        child: Stack(
          children: [
            Material(
              child: GridPaper(
                color: Colors.grey[300]!,
                interval: 25,
                divisions: 1,
                subdivisions: 1,
                child: Container(
                  color: Colors.grey[100],
                ),
              ),
            ),
            Container(
              //color: kKliemannsPink,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                      child: _pageIndex == 1
                          ? Page1(moveToNextPage: increasePageIndex)
                          : Page2(selectedIconData: _selectedIconData) //increaseIdx:

                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final Function moveToNextPage;
  const Page1({
    Key? key,
    required this.moveToNextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FittedBox(
            child: Text(
              "WAS FÜR NEN PROJEKT?",
              style: headerStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 12,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              List<Widget> iconList = List<Widget>.generate(
                iconDataList.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: kKliemannsBlau,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () {
                      moveToNextPage(iconDataList[index]);
                    },
                    child: WiredCard(
                      child: FittedBox(
                        child: Icon(
                          iconDataList[index],
                          size: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              );

              return iconList[index];
            },
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: TextButton(
                    //style: elevatedButtonStyleDefault,
                    child: AutoSizeText(
                      "NÖ",
                      style: GoogleFonts.architectsDaughter(
                        color: Colors.red,
                        fontSize: 100.0,
                      ),
                    ),
                    onPressed: () {
                      print("Nö pressed");
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Page2 extends StatefulWidget {
  final IconData selectedIconData;
  const Page2({
    Key? key,
    required this.selectedIconData,
  }) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final myTextController = TextEditingController();
  TimeOfDay? pickedTime = const TimeOfDay(hour: 8, minute: 0);
  Duration pickedDuration = const Duration(minutes: 90);

  @override
  void dispose() {
    // TODO: implement dispose
    myTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45.0,
          child: FittedBox(
            child: Text(
              "Was?",
              style: headerStyle,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              FittedBox(
                child: Icon(
                  widget.selectedIconData,
                  size: 200.0,
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: WiredInput(
                  controller: myTextController,
                  style: GoogleFonts.architectsDaughter(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                  hintText: "e.g. die Dusche reparieren",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 45.0,
          child: FittedBox(
            child: Text(
              "wann?",
              style: headerStyle,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(child: Container()),
              SizedBox(
                width: 175.0,
                child: pickedTime == null
                    ? Center(
                        child: Text(
                          "xx:xx Uhr",
                          style: GoogleFonts.architectsDaughter(
                            fontSize: 34.0,
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          "${DateFormat("HH:mm").format(
                            DateTime(2022, 2, 6, pickedTime!.hour, pickedTime!.minute),
                          )} Uhr",
                          style: GoogleFonts.architectsDaughter(
                            fontSize: 34.0,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 10.0),
              TextButton(
                //style: elevatedButtonStyleRound,
                onPressed: () async {
                  TimeOfDay initialTime = const TimeOfDay(hour: 12, minute: 0);
                  pickedTime = await showTimePicker(
                    context: context,
                    initialTime: initialTime,
                  );
                  pickedTime ?? initialTime;
                  setState(() {});
                },
                child: const FittedBox(
                  child: Center(
                      child: Icon(
                    MyDoodleIcons.plus,
                    size: 100.0,
                  )),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 45.0,
          child: FittedBox(
            child: Text(
              "wie lang?",
              style: headerStyle,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: TextButton(
                    child: const Icon(
                      MyDoodleIcons.plus,
                      size: 50.0,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // increase duration
                      pickedDuration -= kDurationStep;
                      // limit to min duration
                      pickedDuration =
                          pickedDuration < kMinDuration ? kMinDuration : pickedDuration;

                      setState(() {});
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "${pickedDuration.inHours}:${pickedDuration.inMinutes % 60} Stunde",
                    style: GoogleFonts.architectsDaughter(fontSize: 25.0),
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: TextButton(
                    child: const Icon(
                      MyDoodleIcons.plus,
                      size: 50.0,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // don't allow to go over 24h
                      if (pickedTime!.hour * 60 +
                              pickedTime!.minute +
                              pickedDuration.inMinutes +
                              kDurationStep.inMinutes >
                          60 * 24) {
                        // todo: warning?
                        print("too late");
                      } else {
                        // increase duration
                        pickedDuration += kDurationStep;
                        // limit to max duration
                        pickedDuration =
                            pickedDuration < kMaxDuration ? pickedDuration : kMaxDuration;

                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 50.0,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: TextButton(
                    //style: elevatedButtonStyleDefault,
                    child: AutoSizeText(
                      "NÖ",
                      style: GoogleFonts.architectsDaughter(color: Colors.black, fontSize: 100.0),
                    ),
                    onPressed: () {
                      print("Nö pressed");
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TextButton(
                    child: AutoSizeText(
                      "Yes",
                      style: GoogleFonts.architectsDaughter(color: Colors.black, fontSize: 100.0),
                    ),
                    onPressed: () {
                      print("Jaa pressed");

                      // TODO: check that everything was selected and is correct
                      if (myTextController.text.isEmpty) {
                        print("NO TEXT ENTERED!");
                        // TODO: show warning that text needs to be entered!
                      } else {
                        // TODO: Duration
                        Task task = Task(
                          iconData: widget.selectedIconData,
                          taskDescription: myTextController.text,
                          difficulty: Difficulty.medium,
                          startTime: DateTime(2022, 2, 6, pickedTime!.hour, pickedTime!.minute),
                          duration: pickedDuration,
                          isDone: false,
                        );
                        Provider.of<TaskList>(context, listen: false).add(task);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

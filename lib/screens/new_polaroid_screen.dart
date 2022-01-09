import 'package:flutter/material.dart';
import 'package:mdst_22/config/notifiers.dart';
import 'package:mdst_22/models/models.dart';
import 'package:mdst_22/widgets/polaroid.dart';
import 'package:provider/provider.dart';

class NewPolaroid extends StatelessWidget {
  final Task task;
  final PolaroidFile polaroid;

  const NewPolaroid({
    Key? key,
    required this.task,
    required this.polaroid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: //Image.file(File(imagePath)),
            Column(
          children: [
            Expanded(child: Container()),
            Polaroid(
              polaroid: polaroid,
              title: "name of user",
              text: "picture title",
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "fA1",
                    onPressed: () {
                      // go back to camera
                      Navigator.pop(context);
                    },
                    child: Text("NO"),
                  ),
                  FloatingActionButton(
                    heroTag: "fA2",
                    onPressed: () {
                      // add picture to task
                      Provider.of<TaskList>(context, listen: false).addPolaroid(task, polaroid);
                      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mdst_22/widgets/feed_progress_post.dart';
import 'package:mdst_22/widgets/feed_text_post.dart';
import 'package:mdst_22/widgets/feed_task_post.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxPosts = 10;
    int counter = 1;
    List<Widget> testList = List<Widget>.generate(
      100,
      (index) {
        Widget returnWidget;
        switch (counter) {
          case 1:
            returnWidget = const TaskPost(
              imagePath: "painting.jpg",
              title: "Bibi Bloxberg",
              text: "Neuer Anstrich fürs Büro",
              catImage: "clean.png",
            );
            break;
          case 2:
            returnWidget = const TaskPost(
              title: "Peter Panflöter",
              text: "Keller rauswischen... war mal Zeit",
              catImage: "clean.png",
            );
            break;
          case 3:
            returnWidget = const FeedText(text: "Wie lange muss das trocknen? Jede Menge.");
            break;
          case 4:
            returnWidget = const ProgressBar(
              text: "Bald ist der MDST vorbei...",
              percentage: 0.8,
            );
            break;
          case 5:
            returnWidget = const TaskPost(
              imagePath: "new_employee.jpeg",
              title: "Jimmy",
              text: "Neuen Employee eingestellt",
              catImage: "clean.png",
            );
            break;
          case 6:
            returnWidget = const FeedText(text: "Doch! Nein! Doch! Nein! Doch! Nein!");
            break;
          case 7:
            returnWidget = const TaskPost(
              title: "Schweissgott",
              text: "Gitter mit Hühnerstange verschweisst",
              catImage: "welding.png",
            );
            break;
          case 8:
            returnWidget = const FeedText(
                text: "Macht euch ne Liste, zieht euch ne Schnitthose an und fangt an!");
            break;
          case 9:
            returnWidget = const TaskPost(
              imagePath: "kitchen.jpg",
              title: "Rollathor",
              text: "Küche renoviert!",
              catImage: "clean.png",
            );
            break;
          case 10:
            returnWidget = const FeedText(text: "Es ist kein Pfusch, wenn es funktioniert");
            break;
          default:
            returnWidget = const FeedText(text: "Default Answer");
            break;
        }

        counter = counter >= maxPosts ? 1 : counter + 1;
        return returnWidget;
      },
    );

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cork_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: testList.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 25.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return testList[index];
            },
          ),
        ),
      ],
    );
  }
}

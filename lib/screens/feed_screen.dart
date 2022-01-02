import 'package:flutter/material.dart';
import 'package:mdst_22/config/my_doodle_icons.dart';
import 'package:mdst_22/widgets/feed_text_post.dart';
import 'package:mdst_22/widgets/feed_task_post.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxPosts = 4;
    int counter = 1;
    List<Widget> testList = List<Widget>.generate(
      100,
      (index) {
        Widget returnWidget;
        switch (counter) {
          case 1:
            returnWidget = const TaskPost(
              imagePath: "bibi_tina.jpg",
              title: "Bibi Bloxberg",
              text: "Hab' das Hausboot mal wieder geputzt",
              iconData: MyDoodleIcons.clean,
            );
            break;
          case 2:
            returnWidget = const FeedText(text: "Das sind 2 Motivationen: 🔥🔥");
            break;

          case 3:
            returnWidget = const TaskPost(
              title: "Bibi Bloxberg",
              text: "Hab' das Hausboot mal wieder geputzt",
              iconData: MyDoodleIcons.clean,
            );
            break;
          case 4:
            returnWidget = const FeedText(text: "Flicker Freee");
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
              image: AssetImage("assets/concrete.jpg"),
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

import 'package:flutter/material.dart';
import 'package:mdst_22/widgets/feed_polaroid_post.dart';
import 'feed_no_image_post.dart';

class TaskPost extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String text;
  final IconData iconData;

  const TaskPost({
    Key? key,
    this.imagePath,
    required this.title,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? Polaroid(
            imagePath: imagePath!,
            title: title,
            text: text,
          )
        : NoImagePost(
            title: title,
            text: text,
            iconData: iconData,
          );
  }
}

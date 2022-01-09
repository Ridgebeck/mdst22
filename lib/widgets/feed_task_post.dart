import 'package:flutter/material.dart';
import 'package:mdst_22/widgets/polaroid.dart';
import 'feed_no_image_post.dart';

class TaskPost extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String text;
  final String catImage;

  const TaskPost({
    Key? key,
    this.imagePath,
    required this.title,
    required this.text,
    required this.catImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? NoImagePost(
            title: title,
            text: text,
            catImage: catImage,
          )

        // Polaroid(
        //         // TODO network image
        //         //polaroid: imagePath!,
        //         title: title,
        //         text: text,
        //       )
        : NoImagePost(
            title: title,
            text: text,
            catImage: catImage,
          );
  }
}

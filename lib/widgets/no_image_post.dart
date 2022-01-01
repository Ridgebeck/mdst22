import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdst_22/config/constants.dart';

class NoImagePost extends StatelessWidget {
  final String title;
  final String text;
  final IconData iconData;

  const NoImagePost({
    Key? key,
    required this.title,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Material(
          elevation: kFeedCardElevation,
          child: Container(
            width: constraint.maxWidth,
            color: Colors.blue[100],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FittedBox(
                      child: Text(
                        title,
                        style: headerStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Expanded(
                        child: Icon(
                          iconData,
                          size: 50.0,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        flex: 5,
                        child: AutoSizeText(
                          text,
                          style: GoogleFonts.architectsDaughter(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

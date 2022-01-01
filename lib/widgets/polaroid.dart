import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdst_22/config/constants.dart';

class Polaroid extends StatelessWidget {
  final String imagePath;
  final String title;
  final String text;
  const Polaroid({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double frameWidth = constraint.maxWidth;
        double frameHeight = frameWidth / 0.75;
        double picSize = frameWidth * 0.89;
        double picPadding = (frameWidth - picSize) / 2;

        return Material(
          elevation: kFeedCardElevation,
          child: Container(
            color: kPolaroidColor,
            height: frameHeight,
            width: frameWidth,
            child: Padding(
              padding: EdgeInsets.all(picPadding),
              child: Column(
                children: [
                  Container(
                    height: picSize,
                    width: picSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/" + imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 9,
                    child: AutoSizeText(
                      title,
                      style: headerStyle,
                    ),
                  ),
                  Expanded(
                    //flex: 8,
                    child: AutoSizeText(
                      text,
                      style: GoogleFonts.permanentMarker(
                        fontSize: 50.0,
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/config/filters.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mdst_22/models/models.dart';

class Polaroid extends StatelessWidget {
  final PolaroidFile polaroid;
  final String title;
  final String text;
  const Polaroid({
    Key? key,
    required this.polaroid,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double frameWidth = constraint.maxWidth;
        double frameHeight = frameWidth / 0.85316;
        double picSize = frameWidth * 0.88;
        double picPadding = (frameWidth - picSize) / 2;

        return Material(
          elevation: kFeedCardElevation,
          color: Colors.transparent,
          child: Container(
            //color: kPolaroidColor,
            height: frameHeight,
            width: frameWidth,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/polaroid_paper.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.red,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(picPadding, picPadding, picPadding, 0),
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.matrix(polaroid.filter.matrix),
                    child: Image.file(File(polaroid.imagePath)),

                    // Image.asset(
                    //   "assets/" + imagePath,
                    //   width: picSize,
                    //   height: picSize,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  // Container(
                  //   height: picSize,
                  //   width: picSize,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/" + imagePath),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    //flex: 9,
                    child: AutoSizeText(
                      title,
                      style: headerStyle.copyWith(
                        color: Colors.indigo.withOpacity(0.95),
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 8,
                    child: AutoSizeText(
                      text,
                      style: GoogleFonts.permanentMarker(
                        fontSize: 50.0,
                        color: Colors.black.withOpacity(0.75),
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

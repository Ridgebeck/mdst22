import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdst_22/config/constants.dart';

class FeedText extends StatelessWidget {
  final String text;
  const FeedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Material(
          elevation: kFeedCardElevation,
          child: Container(
            width: constraint.maxWidth,
            color: kKliemannsPink,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.architectsDaughter(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mdst_22/config/constants.dart';

class FeedText extends StatelessWidget {
  final String text;
  const FeedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kFeedCardElevation,
      child: Container(
        color: kKliemannsPink,
        child: Padding(
          padding: kFeedCardPadding,
          child: Text(
            text,
            style: feedTextStyle,
          ),
        ),
      ),
    );
  }
}

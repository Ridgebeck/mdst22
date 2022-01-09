import 'package:flutter/material.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:wired_elements/wired_elements.dart';

class ProgressBar extends StatefulWidget {
  final String text;
  final double percentage;
  const ProgressBar({
    Key? key,
    required this.text,
    required this.percentage,
  })  : assert(percentage > 0.0 && percentage < 1.0),
        super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController myController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: kFeedCardElevation,
      child: Container(
        color: Colors.grey[200], // kKliemannsPink,
        child: Padding(
          padding: kFeedCardPadding,
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  widget.text,
                  style: feedTextStyle,
                ),
              ),
              const SizedBox(height: 10.0),
              WiredProgress(
                controller: myController,
                value: widget.percentage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

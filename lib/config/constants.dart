import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: convert to theme

// team colors
const Color kTeamFynn = kKliemannsPink;
const Color kTeamBrian = Color(0xff32c7d6);

// color scheme
const Color kKliemannsPink = Color(0xffE7C7D6);
const Color kKliemannsBlau = Color(0xff303C50);
const Color kKliemannsSchwarz = Color(0xff0A1A21);
Color kPolaroidColor = Colors.grey[100]!;
// text scheme
TextStyle headerStyle = GoogleFonts.permanentMarker(
  fontSize: 100,
  color: Colors.indigo[800],
);
TextStyle feedTextStyle = GoogleFonts.architectsDaughter(fontSize: 20.0);

// general
const kAppBarHeight = 80.0;
const kTabBarHeight = 70.0;

// pop up screen
const kDialogPadding = 10.0;

// task creation
const kMinDuration = Duration(minutes: 30);
const kDurationStep = Duration(minutes: 30);
const kMaxDuration = Duration(minutes: 8 * 60);

// task list screen
const double kTaskCardElevation = 10.0;

// feed screen
const double kFeedCardElevation = 10.0;
const EdgeInsets kFeedCardPadding = EdgeInsets.all(20.0);

const List<String> kMarkerLines = ["line1.png", "line2.png", "line3.png", "line4.png"];

// camera / taking picture screen
Color kBackgroundShade = Colors.black.withOpacity(0.9);

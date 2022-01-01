import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: convert to theme
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

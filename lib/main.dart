import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/globals.dart';
import 'config/notifiers.dart';
import 'package:mdst_22/config/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';
import 'package:mdst_22/screens/task_list_screen.dart';
import 'package:mdst_22/screens/feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Ensure plugin services are initialized
  cameras = await availableCameras();
  print("CAMERAS: $cameras"); //Get list of available cameras

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const TaskListScreen(),
    const StatsScreen(),
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.green,
        //extendBody: true,
        bottomNavigationBar: Theme(
          data: ThemeData(),
          child: Container(
            height: kTabBarHeight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[800]!,
                  blurRadius: 9,
                )
              ],
              image: const DecorationImage(
                image: AssetImage("assets/cardboard.jpg"),
                fit: BoxFit.cover,
              ),
              //color: kKliemannsBlau,
              // image: const DecorationImage(
              //   image: AssetImage("assets/tab_bar.jpg"),
              // ),
            ),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[800],
              indicatorColor: Colors.transparent,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset("assets/home.png"),
                  ),
                ),
                Tab(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset("assets/list.png"),
                  ),
                ),
                Tab(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset("assets/megaphone.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: Center(
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                heroTag: "profileButton",
                onPressed: () {},
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          toolbarHeight: kAppBarHeight,
          flexibleSpace: const Image(
            image: AssetImage('assets/duct_tape.jpg'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              "#MDST22",
              style: GoogleFonts.permanentMarker(
                fontSize: 50.0,

                color: kTeamBrian, //Colors.white,
                //fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(), //const NeverScrollableScrollPhysics(),
          children: MyApp._widgetOptions,
        ),
        //MyApp._widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

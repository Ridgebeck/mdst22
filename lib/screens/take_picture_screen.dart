import 'dart:ui';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:mdst_22/config/constants.dart';
import 'package:mdst_22/config/filters.dart';
import 'package:mdst_22/config/globals.dart';
import 'package:mdst_22/models/models.dart';
import 'package:mdst_22/screens/new_polaroid_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const int kFlexTop = 1;
const int kFlexBottom = 2;

class TakePicture extends StatefulWidget {
  final Task task;
  const TakePicture({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> with WidgetsBindingObserver {
  late CameraController controller;
  Filter selectedFilter = Filter.noFilter;
  int mainCameraIndex = 0;
  late int frontCameraIndex;
  bool mainCameraIsActive = true;
  bool flashIsOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // don't show status bar on this screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    // todo: check if camera list is null?!
    if (cameras != null) {
      // find index of front facing camera
      frontCameraIndex =
          cameras!.indexWhere((cam) => cam.lensDirection == CameraLensDirection.front);
      // initialize with mainCameraIndex
      _initCamera(mainCameraIndex).then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
    // TODO: handle if camera list is null
    else {
      print("NO CAMERAS!");
    }
  }

  @override
  void dispose() {
    // dispose controller
    controller.dispose();
    // show status bar again
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _initCamera(int cameraNo) async {
    try {
      controller = CameraController(
        cameras![cameraNo],
        ResolutionPreset.max,
        enableAudio: false,
      );
      await controller.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      // todo: handle error
      print("ERROR WHILE INITIALIZING CAMERA! : $e");
    }
  }

  void _onCapturePressed(BuildContext context) async {
    try {
      // necessary?
      await controller.initialize();
      // take a picture
      print("try taking an image");
      XFile xFile = await controller.takePicture();
      // convert XFile to img.Image
      final img.Image image = img.decodeImage(File(xFile.path).readAsBytesSync())!;

      // TODO: find directory when app is starting and save globally
      final Directory docDirectory = await getApplicationDocumentsDirectory();
      // same for screen dimensions?
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;

      print("screen aspect ratio: ${1 / MediaQuery.of(context).size.aspectRatio}");
      print("view/picture aspect ratio: ${controller.value.aspectRatio}");

      // TODO: what if aspect ratio of camera is wider than phone?!
      double topScreenMargin = (screenHeight - screenWidth) * kFlexTop / (kFlexBottom + kFlexTop);
      int topImageMargin = (topScreenMargin / screenWidth * image.width).round();

      print("topScreenMargin: $topScreenMargin");
      print("topImageMargin: $topImageMargin");

      // crop img.Image
      print("cropping image");
      int width = image.width;
      img.Image croppedImage = img.copyCrop(image, 0, topImageMargin, width, width);
      // save cropped image in document directory (permanent app memory)
      String imagePath = "${docDirectory.path}/${basename(xFile.path)}";
      File(imagePath).writeAsBytesSync(img.encodeJpg(croppedImage));

      // navigate to next site
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewPolaroid(
            task: widget.task,
            polaroid: PolaroidFile(imagePath: imagePath, filter: selectedFilter),
          ),
        ),
      );
    } catch (e) {
      // todo: error handling while saving
      print(e);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (!controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera(0);
    }
  }

  Widget _cameraPreviewWidget() {
    if (!controller.value.isInitialized) {
      return Container(
        color: Colors.purpleAccent,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return

        //   AspectRatio(
        //   aspectRatio: 720 / 1280,
        //   child: Container(
        //     width: 720,
        //     height: 1280,
        //     decoration: BoxDecoration(
        //       color: Colors.purple,
        //       border: Border.all(
        //         color: Colors.lightBlue,
        //         width: 5.0,
        //       ),
        //     ),
        //   ),
        // );
        CameraPreview(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // needed to cover full screen
          //width: double.infinity,
          //height: double.infinity,
          child: _cameraPreviewWidget(), //CameraPreview(controller),
        ),
        Column(
          children: [
            Expanded(
              flex: kFlexTop,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [kBackgroundShade, Colors.black],
                    //stops: const [0.2, 1.0],
                  ),
                ),
              ),
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ColorFilter.matrix(selectedFilter.matrix),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Expanded(
              flex: kFlexBottom,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kBackgroundShade, Colors.black],
                    //stops: const [0.2, 1.0],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: "f1Button",
                            child: const Icon(Icons.filter_1),
                            onPressed: () {
                              selectedFilter = Filter.values[0];
                              setState(() {});
                            },
                          ),
                          FloatingActionButton(
                            heroTag: "f2Button",
                            child: const Icon(Icons.filter_2),
                            onPressed: () {
                              selectedFilter = Filter.values[1];
                              setState(() {});
                            },
                          ),
                          FloatingActionButton(
                            heroTag: "f3Button",
                            child: const Icon(Icons.filter_3),
                            onPressed: () {
                              selectedFilter = Filter.values[2];
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: FloatingActionButton(
                              heroTag: "flashButton",
                              child: Icon(
                                flashIsOn ? Icons.flash_on : Icons.flash_off,
                                size: 20,
                              ),
                              onPressed: () {
                                // toggle flash
                                controller
                                    .setFlashMode(flashIsOn ? FlashMode.off : FlashMode.always);
                                flashIsOn = !flashIsOn;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: 75.0,
                            width: 75.0,
                            child: FloatingActionButton(
                              heroTag: "camButton",
                              child: const Icon(
                                Icons.camera,
                                size: 50,
                              ),
                              onPressed: () {
                                _onCapturePressed(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: FloatingActionButton(
                              heroTag: "flipButton",
                              child: const Icon(
                                Icons.flip_camera_android,
                                size: 20,
                              ),
                              onPressed: () {
                                // TODO: transition between cameras / loading widget
                                // init main or front camera
                                _initCamera(
                                    mainCameraIsActive ? frontCameraIndex : mainCameraIndex);
                                // save new state
                                mainCameraIsActive = !mainCameraIsActive;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

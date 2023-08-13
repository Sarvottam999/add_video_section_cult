//
//
//

import 'dart:async';
import 'dart:io';

import 'package:add_video/components/add_Video/add_video_provider.dart';
import 'package:add_video/components/add_Video/draft_screen.dart';
import 'package:add_video/components/add_Video/s_2_edit_video.dart';
import 'package:add_video/components/add_Video/s_5_add_video_form/s_5_add_video_form_screen.dart';
import 'package:add_video/components/add_Video/widgets/ToastAnimatedWidget.dart';
import 'package:add_video/components/add_Video/widgets/timerCustomToast.dart';
import 'package:add_video/main.dart';
import 'package:add_video/provider/video_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

import 'package:add_video/constant/constant.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:tryapp3/components/add_Video/s_2_edit_video.dart';

// List<CameraDescription>? camera;
List<CameraDescription> camera = [];

class s_1_video_screen extends StatefulWidget {
  static const namedRoute = '/s_1_video_screen';
  const s_1_video_screen({super.key});

  @override
  State<s_1_video_screen> createState() => _s_1_video_screenState();
}

class _s_1_video_screenState extends State<s_1_video_screen>  with RouteAware{


  CameraController? _cameraController;
  bool _isRearCameraSelected = true;
  bool _isCameraInitialized = false;

  Future<void>? cameravalue;
  bool isrecording = false;
  bool _isRecordingInProgress = false;
  bool _flash = false;
  late File _videoFile;

  // List<File> allFileList = [];

  //progreess
  Timer? timer;
  bool _loading = false;
  double _progressValue = 0.0;
  var counter = 60;

  bool popup_open = false;

  String videoPath = "";
  bool _isInit = true;

  @override
  void initState() {
    super.initState();

    try {
      // check_popup();
      // Future.delayed(Duration.zero).then((_) {
      //   check_popup();
      // });

          dismiss();
      onNewCameraSelected(camera[0]);
    } catch (e) {
      print(e);
    }

    // print(cameravalue!.asStream());

    FocusManager.instance.primaryFocus?.unfocus();

  }
  



  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     dismiss();
  //     onNewCameraSelected(camera[0]);
  //   }

  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }
    @override
  void didPush() {
      Future.delayed(Duration.zero).then((_) {
        check_popup();
      });
    print('*** Entering screen: {widget.routeName}');
  }


//  void didPushNext() {
//     print('*** Leaving screen: {widget.routeName}');
//     // onLeaveScreen();
//   }

  // @override
  // void didPop() {
  //   print('*** Going back, leaving screen: {widget.routeName}');
  //   // onLeaveScreen();
  // }

  @override
  void didPopNext() {
      Future.delayed(Duration.zero).then((_) {
        check_popup();
      });
    print('*** Going back to screen: {widget.routeName}');
  }

  check_popup() async {
    final _add_video_provider =
        Provider.of<add_video_provider>(context, listen: false);
    popup_open = await _add_video_provider.location_out_of_bound_check();
    popup_open ?  null :show_dialog();
    // popup_open ?   show_dialog() : null;

  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   print("object siapose");
  //   _cameraController!.dispose();
  // }

  show_dialog() {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            height: 400.0,
            // width: 420.0,
            // margin: EdgeInsets.only(left: 30.0, right: 30.0),
            padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
            // color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(asset.addVideo_Popup),
                Container(
                  height: 80.0,
                  width: c_width,
                  child: Text(
                      "Your range is getting extended,Please upload or save your last recordingsfirst, Your drafts will be available under the setting option.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400)),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.pop(context, 'OK');

                      Navigator.pushNamed(context,add_video_form_screen.namedRoute );


                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => s_2_edit_video_screen()),
                      // );
                      
                       

                      
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Color(0xffFB8C00),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )),
    );
  }



  void onNewCameraSelected(CameraDescription cameraDescription) async {
    print("---------- onNewCameraSelected function  ");
    final previousCameraController = _cameraController;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _cameraController = cameraController;
        print("---------- _cameraController set  ");
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _cameraController!.value.isInitialized;
      });
    }

    print("---------- end of function  ");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

// -------------------------------  timer
  static void show(BuildContext context) {
    Color textColor = Colors.white;
    dismiss();
    _createView(context, textColor);
  }

  static OverlayEntry? _overlayEntry;
  static bool isVisible = false;

  static void _createView(
    BuildContext context,
    Color textColor,
  ) async {
    var overlayState = Overlay.of(context);

    // final themeData = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastAnimatedWidget(
          // child:
          ),
    );
    isVisible = true;
    overlayState!.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry?.remove();
  }

  // void printlist() {
  //   print("allFileList.length");
  // }

  // void printpath() {
  //   print("allFileList[0].path");
  // }

  @override
  Widget build(BuildContext context) {
// ------------------------------------------------

    Future<void> startVideoRecording() async {
      // final CameraController? cameraController = controller;
      if (_cameraController!.value.isRecordingVideo) {
        // A recording has already started, do nothing.
        return;
      }
      try {
        await _cameraController!.startVideoRecording();
        setState(() {
          _isRecordingInProgress = true;
          print(_isRecordingInProgress);
        });
      } on CameraException catch (e) {
        print('Error starting to record video: $e');
      }
    }

    Future<bool?> stopVideoRecording() async {
      if (!_cameraController!.value.isRecordingVideo) {
        // Recording is already is stopped state
        return false;
      }
      try {
        XFile file = await _cameraController!.stopVideoRecording();
        setState(() {
          _isRecordingInProgress = false;
          print(_isRecordingInProgress);
        });

        File videoFile = File(file.path);

        int currentUnix = DateTime.now().millisecondsSinceEpoch;
        final directory = await getApplicationDocumentsDirectory();
        String fileFormat = videoFile.path.split('.').last;

        File temp = await videoFile.copy(
          '${directory.path}/$currentUnix.$fileFormat',
        );
        // loaded_video_model.add(temp);
        setState(() {
          _videoFile = temp;
          final _add_video_provider =
              Provider.of<add_video_provider>(context, listen: false);

          _add_video_provider.addVideo(_videoFile);
          // allFileList.add(_videoFile);

          _isRecordingInProgress = false;
          print(_isRecordingInProgress);
        });

        return true;
      } on CameraException catch (e) {
        print('Error stopping video recording: $e');
        return null;
      }
    }
// ------------------------------------------------

    void _updateProgress() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        counter--;
        print(counter);
        setState(() {
          _progressValue += 1.0 / 60;
        });
        if (counter == 0) {
          print('Cancel timer');
          setState(() {
            timer.cancel();

            _progressValue = 0.0;

            _loading = false;
            counter = 60;
          });
          await stopVideoRecording();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => s_2_edit_video_screen()),
          );
        }
      });
    }

// ---------------------
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // --------------------------------- camera -----------
            // FutureBuilder(
            //   future: cameravalue,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return SizedBox(
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height,
            //         child: _cameraController!.buildPreview(),
            //       );
            //       // CameraPreview(_cameraController!);
            //     } else {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     ;
            //   },
            // ),

            _isCameraInitialized
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: _cameraController!.buildPreview(),
                  )
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(82, 0, 0, 0),
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            width: 60,
                            // color: Color.fromARGB(255, 218, 218, 218),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(0, 251, 138, 0),
                                border: Border(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: const Icon(
                              Icons.add,
                              weight: 30,
                              size: 30,
                              color: Color.fromARGB(0, 255, 255, 255),
                            ),
                            // ),-----------------------
                          ),
                        ),
                        const Text(
                          "Rotate Camera",
                          style: TextStyle(
                              color: Color.fromARGB(0, 255, 255, 255)),
                        ),
                      ],
                    ),
                    // ------------------------------------------------------------------------
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 65.0,
                          width: 65.0,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 65.0,
                                  width: 65.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5.0,
                                    backgroundColor: colorAssets.ORANGE,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 0, 0, 0)),
                                    value: _progressValue,
                                  ),
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        if (!_cameraController!
                                            .value.isRecordingVideo) {
                                          // Recording is already is stopped state
                                          setState(() {
                                            if (_loading == false) {
                                              _loading = true;

                                              _updateProgress();
                                            }
                                          });
                                          print("clicked");
                                          startVideoRecording();
                                          show(context);
                                        } else {
                                          timer!.cancel();
                                          dismiss();
                                          setState(() {
                                            _progressValue = 0.0;
                                            counter = 60;

                                            _loading = false;
                                          });

                                          await stopVideoRecording();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    s_2_edit_video_screen()),
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    // onTapUp: (_) async {

                                    // },
                                    child: CircleAvatar(
                                      backgroundColor: !_isRecordingInProgress
                                          ? colorAssets.ORANGE
                                          : Colors.white,
                                      foregroundColor: !_isRecordingInProgress
                                          ? colorAssets.ORANGE
                                          : Colors.white,
                                      radius: 30,
                                      child: Icon(
                                        Icons.circle_outlined,
                                        weight: 10,
                                        size: 60,
                                        color: !_isRecordingInProgress
                                            ? Colors.white
                                            : colorAssets.ORANGE,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Start Recording",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            onTap: () {
                              print("clicked!");
                              setState(() {
                                _isCameraInitialized = false;
                              });
                              onNewCameraSelected(
                                camera[_isRearCameraSelected ? 0 : 1],
                              );
                              setState(() {
                                _isRearCameraSelected = !_isRearCameraSelected;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           s_2_edit_video_screen()),
                              // );
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: colorAssets.ORANGE,
                                    border: Border(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: SvgPicture.asset(
                                    asset.rotateCameraIcon,
                                    height: 1.0,
                                    width: 1.0,
                                  ),
                                )

                                // Icon(
                                //   _isRearCameraSelected
                                //       ? Icons.camera_front
                                //       : Icons.camera_rear,
                                //   color: Color.fromARGB(255, 255, 255, 255),
                                // )

                                )),
                        GestureDetector(
                          onTap: () => {
                            //  printlist()
                          },
                          child: const Text(
                            "Rotate Camera",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                height: 90,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<add_video_provider>(
                        builder: (ctx, provider, child) => provider.getback
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(20),

                                  // height: 50,
                                  // width: 50,
                                  // decoration: BoxDecoration(
                                  //     color: colorAssets.ORANGE,
                                  //     border: Border.all(),
                                  //     borderRadius: BorderRadius.all(Radius.circular(20))),

                                  // color: colorAssets.ORANGE,
                                  child: const Text(
                                    "< Back",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: fontwightAssets.Bold,),
                                  ),
                                ),
                              )
                            : Container(
                                height: 25.0,
                                width: 60.0,
                                color: Colors.black,
                              )),
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 50,
                      width: 50,
                      // decoration: BoxDecoration(
                      //     color: colorAssets.ORANGE,
                      //     border: Border.all(),
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),

                      // color: colorAssets.ORANGE,
                      child: IconButton(
                          onPressed: () {
                            _flash = !_flash;
                              //  Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           draft_screen()),
                              // );
                            

                            // _flash
                            //     ? _cameraController!
                            //         .setFlashMode(FlashMode.torch)
                            //     : _cameraController!
                            //         .setFlashMode(FlashMode.off);
                          },
                          icon: _flash
                              ? const Icon(Icons.flash_on, color: Colors.white)
                              : const Icon(Icons.flash_off,
                                  color: Colors.white)),
                    ),
                    Consumer<add_video_provider>(
                      builder: (ctx, provider, child) => provider.getback
                          ? Container(
                              height: 25.0,
                              width: 60.0,
                              color: Colors.black,
                            )
                          : IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          s_2_edit_video_screen()),
                                );
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 35.0,
                                weight: 25.0,
                              )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _updateProgress() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     print(timer.tick);
  //     counter--;
  //     setState(() {
  //       _progressValue += 1.0 / 60;
  //     });
  //     if (counter == 0) {
  //       print('Cancel timer');
  //       timer.cancel();
  //     }
  //   });
  // }
}

// import 'package:culturtap/constants/constant.dart';
// import 'package:culturtap/screens/add_video_camera/2_edit_video.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:camera/camera.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// List<CameraDescription>? camera;

// class s_1_s_1_video_screen extends StatefulWidget {
//   const s_1_s_1_video_screen({super.key});

//   @override
//   State<s_1_s_1_video_screen> createState() => _s_1_s_1_video_screenState();
// }

// class _s_1_s_1_video_screenState extends State<s_1_s_1_video_screen> {
//   CameraController? _cameraController;
//   Future<void>? cameravalue;
//   bool isrecording = false;
//   bool _isRecordingInProgress = false;
//   bool _flash = false;

//   String videoPath = "";

//   @override
//   void initState() {
//     _cameraController = CameraController(camera![0], ResolutionPreset.high);
//     cameravalue = _cameraController!.initialize();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _cameraController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<void> startVideoRecording() async {
//       // final CameraController? cameraController = controller;
//       if (_cameraController!.value.isRecordingVideo) {
//         // A recording has already started, do nothing.
//         return;
//       }
//       try {
//         await _cameraController!.startVideoRecording();
//         setState(() {
//           _isRecordingInProgress = true;
//           print(_isRecordingInProgress);
//         });
//       } on CameraException catch (e) {
//         print('Error starting to record video: $e');
//       }
//     }

// // ------------------------------------------------
//     Future<XFile?> stopVideoRecording() async {}

// // ---------------------
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // --------------------------------- camera -----------
//             FutureBuilder(
//               future: cameravalue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return CameraPreview(_cameraController!);
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 ;
//               },
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 height: 150,
//                 width: double.infinity,
//                 child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       // mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 50,
//                           // color: Color.fromARGB(255, 218, 218, 218),
//                           decoration: BoxDecoration(
//                               color: colorAssets.ORANGE,
//                               border: Border.all(),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50))),
//                           child: Icon(
//                             Icons.add,
//                             weight: 30,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                           // ),-----------------------
//                         ),
//                        Text(
//                           "Upload",
//                           style: TextStyle(color: Colors.white),
//                         ),

//                       ],
//                     ),
//                     // ------------------------------------------------------------------------
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,

//                       // mainAxisSize: MainAxisSize.min,
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                           GestureDetector(
//                             onTap: () {
//                               startVideoRecording();
//                             },
//                             onTapUp: (_) async {
//                               if (!_cameraController!.value.isRecordingVideo) {
//                                 // Recording is already is stopped state
//                                 return null;
//                               }
//                               try {
//                                 XFile file = await _cameraController!
//                                     .stopVideoRecording();
//                                 setState(() {
//                                   _isRecordingInProgress = false;
//                                   videoPath = file.path;
//                                   print(_isRecordingInProgress);
//                                 });
//                               } on CameraException catch (e) {
//                                 print('Error stopping video recording: $e');
//                               }

//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) =>
//                               //           edit_s_1_s_1_video_screen(path: videoPath),
//                               //     ));
//                             },
//                             child:
//                             CircleAvatar(
//                               backgroundColor: !_isRecordingInProgress ? colorAssets.ORANGE:Colors.white ,
//                               foregroundColor:!_isRecordingInProgress ? colorAssets.ORANGE:Colors.white ,
//                               radius: 48,
//                               child: Icon(
//                                 Icons.circle_outlined,
//                                 weight: 10,
//                                 size: 90,
//                                 color: !_isRecordingInProgress ?Colors.white: colorAssets.ORANGE,
//                               ),
//                             )),

//                         Text(
//                           "Add Video",
//                           style: TextStyle(color: Colors.white),
//                         ),

//                       ],
//                     ),

//                   Column(
//                     children: [
//                           Container(
//                           height: 50,
//                           width: 50,
//                           // color: Color.fromARGB(255, 218, 218, 218),
//                           decoration: BoxDecoration(
//                               color: Color.fromARGB(255, 0, 0, 0),
//                               border: Border.all(),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: Icon(
//                             Icons.add,
//                             weight: 10,
//                             size: 20,
//                             color: Color.fromARGB(255, 0, 0, 0),
//                           ),
//                           // ),-----------------------
//                         ),

//                          Text(
//                           "try",
//                           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//                         ),

//                     ],

//                   )

//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 color: Color.fromARGB(255, 0, 0, 0),
//                 height: 100,
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(20),

//                       height: 50,
//                       width: 50,
//                       // decoration: BoxDecoration(
//                       //     color: colorAssets.ORANGE,
//                       //     border: Border.all(),
//                       //     borderRadius: BorderRadius.all(Radius.circular(20))),

//                       // color: colorAssets.ORANGE,
//                       child: Text(
//                         "< back",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       height: 50,
//                       width: 50,
//                       // decoration: BoxDecoration(
//                       //     color: colorAssets.ORANGE,
//                       //     border: Border.all(),
//                       //     borderRadius: BorderRadius.all(Radius.circular(20))),

//                       // color: colorAssets.ORANGE,
//                       child: IconButton(
//                           onPressed: () {
//                             _flash = !_flash;
//                             _flash
//                                 ? _cameraController!
//                                     .setFlashMode(FlashMode.torch)
//                                 : _cameraController!
//                                     .setFlashMode(FlashMode.off);
//                           },
//                           icon: _flash
//                               ? Icon(Icons.flash_on, color: Colors.white)
//                               : Icon(Icons.flash_off, color: Colors.white)),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

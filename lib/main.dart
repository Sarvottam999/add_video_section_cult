import 'package:add_video/components/add_Video/draft.dart';
import 'package:add_video/components/add_Video/s_2_edit_video.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:add_video/components/add_Video/add_video_provider.dart';
import 'package:add_video/components/add_Video/s_1_video_screen.dart';
import 'package:add_video/components/add_Video/s_5_add_video_form/s_5_add_video_form_screen.dart';

// import 'package:add_video/temp2.dart';
Future<void> main() async {
  // runApp(const MyApp());

  try {
    WidgetsFlutterBinding.ensureInitialized();
    camera = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MultiProvider(providers: [
    // ChangeNotifierProvider(create: (_) => FormProvider()),
    ChangeNotifierProvider(create: (_) => add_video_provider()),
    ChangeNotifierProvider(
      create: (_) => draft(),
    ),
  ], child: MyApp()
      // child: temp( )

      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Poppins',
      ),
      navigatorObservers: [routeObserver],

      home:

          // CameraScreen()
          //  p1()
          // ProviderFormPage()
          // PostsOverviewScreen()
          // ChangeNotifierProvider(
          // create: (ctx) => video_provider(),

          // child : Container(
          //   child: Text("data"),
          // )
          // AuthScreen()
          s_1_video_screen(),
      // MyHomePageState()
      // add_video_form_screen()
      // myEditSetting()
      // temp2()
      // CircularProgressIndicatorApp()

      //   Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Blog App"),
      //     centerTitle: true,
      //   ),
      //   body: Column(
      //     children: [
      //       p_1_products_over_screen(),
      //       p_1_products_over_screen(),

      //     ],
      //   ),
      // )

      //  initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => const MyApp(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        s_1_video_screen.namedRoute: (context) => const s_1_video_screen(),
        s_2_edit_video_screen.namedRoute: (context) =>
            const s_2_edit_video_screen(),
        add_video_form_screen.namedRoute: (context) =>
            const add_video_form_screen(),
      },
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Scaffold(appBar: AppBar(title: Text("demo"),),
    //   body:ChangeNotifierProvider(
    //   create: (ctx) => video_provider(),

    //   child :  h_1_home(),),)
    // );
  }
}

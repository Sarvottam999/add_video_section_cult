import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class asset {
  // ------------    login   -----------------------
  static const img1 = 'assets/login/i1_roadAndGirl.png';
  static const img2 = 'assets/login/i2_girlOnCar.png';
  static const img3 = 'assets/login/i3_boyWithPing.png';
  static const img4 = 'assets/login/i4_mapLocation.png';

  // static const CULTURTAPLOGO = 'assets/img/culturtap_logo.svg';
  static const CULTURTAPLOGO = 'assets/login/logo1.svg';

  static const PINGLOGO = 'assets/img/ping.svg';
  static const EMPTY_IMAGE_WARN = 'assets/warning_empy_img.svg';

  // ------------------home----------------------------------------------------------------
  static const setting_filled_icons = 'assets/img/culturtap_logo.svg';
  static const setting_outlined_icons = 'assets/img/culturtap_logo.svg';
  static const demo_video = 'assets/videos/v2.mp4';
  // ------------------edit profile----------------------------------------------------------------
  static const edit_avtar = 'assets/profile_edit/avtar.svg';
  static const banner1 = 'assets/profile_edit/banner/b1.png';
  static const banner2 = 'assets/profile_edit/banner/b2.png';
  static const banner3 = 'assets/profile_edit/banner/b3.png';

  static const  rotateCameraIcon = "assets/camera/rotate_camera.svg";
  static const  addVideo_Popup = "assets/camera/popup-addvideo.png";
  static const draft_icon = "assets/camera/draft-icon.svg";

}

class api {
  static const String baseUrl = 'http://3.108.165.39:8080';
  // 'http://127.0.0.1:8000';
  // "http://172.21.19.104:8000";

  //  "http://192.168.57.215:8000";
  // 'https://hawxwzzhiokniceoeylxwo6kmu0buhho.lambda-url.ap-south-1.on.aws';
  static const String get_video =
      '/videos/get?token=a53afbb8-1920-4540-ac64-69ee6ad76280';
  static const String add_user =
      "user/add?token=a53afbb8-1920-4540-ac64-69ee6ad76280";
  static const String get_otp = "/sms/otp/";
  static const String get_AddressFromCoordiates = "/location?";
  static const String add_video_files = "/videos/add-video?";
  static const String add_video_description = "/videos/add";
  static const String token_key = "a53afbb8-1920-4540-ac64-69ee6ad76280";
  static const String cord_measure = "/compare-location?";

}

// ----------------------------------------------------------------

class colorAssets {
  static const ORANGE = Color(0xffFB8C00);
  static const WHITE = Colors.white;
  static const BLACK = Colors.black;
  static const RED = Color(0xffFF0000);
  static const GREEN = Color(0xff0A8100);
}

class fontwightAssets {
  static const Thin = FontWeight.w100;
  static const ExtraLight = FontWeight.w200;
  static const Light = FontWeight.w300;
  static const Regular = FontWeight.w400;
  static const Medium = FontWeight.w500;
  static const SemiBold = FontWeight.w600;
  static const Bold = FontWeight.w700;
  static const ExtraBold = FontWeight.w800;
  static const Blank = FontWeight.w900;
}

class textstyleAssets {
  //14
  static const Regular14 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Regular,
  );
  //16
  static const Bold12 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Bold,
  );
  //16
  static const Bold16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Bold,
  );
  //12
  static const Regular12 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Regular,
  );
  //16
  static const Regular16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Regular,
  );
  //14
  static const Blank14 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Blank,
  );
  //16
  static const Blank16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Blank,
  );
  //18
  static const Blank18 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Blank,
  );

  //16
  static const SemiBold16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.SemiBold,
  );
  //16
  static const ExtraBold16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.SemiBold,
  );
  //16
  static const Medium16 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: fontwightAssets.Medium,
  );

//   static textstyle(
//       {myfontSize = 14.0,
//       myfontWeight = FontWeight.w400,
//       mycolor = Colors.black}) {
//     return TextStyle(
//         fontSize: myfontSize, fontWeight: myfontWeight, color: mycolor);
//   }
// }

// class texttype {
//   static final t1 = textstyleAssets.textstyle(
//       myfontSize: 20.0, myfontWeight: fontwightAssets.ExtraBold);
// // ----------------------------------------------------------------

//   static t2(
//       {color = colorAssets.BLACK,
//       myfontSize = 18.0,
//       myfontWeight = fontwightAssets.Bold}) {
//     return textstyleAssets.textstyle(
//         mycolor: color, myfontSize: myfontSize, myfontWeight: myfontWeight);
//   }
// // ----------------------------------------------------------------

//   static final t3 = textstyleAssets.textstyle(
//       myfontSize: 18.0, myfontWeight: fontwightAssets.Regular);
// // ----------------------------------------------------------------
//   static final t4 = textstyleAssets.textstyle(
//     mycolor: colorAssets.WHITE,
//     myfontSize: 16.0,
//     myfontWeight: fontwightAssets.Regular,
//   );

//   static final t5 = textstyleAssets.textstyle(
//       mycolor: colorAssets.WHITE,
//       myfontSize: 16.0,
//       myfontWeight: fontwightAssets.Bold);
//   static final bold14 = textstyleAssets.textstyle(
//       myfontSize: 18.0, myfontWeight: fontwightAssets.Bold);

//   static final bold18 = textstyleAssets.textstyle(
//       myfontSize: 18.0, myfontWeight: fontwightAssets.Bold);

//   static final bold29 = TextStyle(
//       color: Color.fromARGB(255, 0, 0, 0),
//       fontSize: 29.0,
//       fontWeight: fontwightAssets.Bold);

//   static final blank14 = textstyleAssets.textstyle(
//       myfontSize: 14.0, myfontWeight: fontwightAssets.Bold);
//   static final medium14 = textstyleAssets.textstyle(
//       myfontSize: 14.0, myfontWeight: fontwightAssets.Medium);
//   static final semibold14 = textstyleAssets.textstyle(
//       myfontSize: 14.0, myfontWeight: fontwightAssets.SemiBold);
//   static final extrabold18 = textstyleAssets.textstyle(
//       myfontSize: 18.0, myfontWeight: fontwightAssets.ExtraBold);
//   static final reguler30 = TextStyle(
//       color: colorAssets.ORANGE,
//       fontWeight: fontwightAssets.Regular,
//       fontSize: 30);

  //  there are two type of there are two
}

class iconAssets {
  static const person_circuler = Icon(Icons.account_circle_rounded,
      size: 40, color: Color.fromARGB(255, 0, 0, 0));

  static const sms_outlined =
      Icon(Icons.sms_outlined, size: 35, color: Color.fromARGB(255, 0, 0, 0));
}

// ----------------------------------------------------------------

class iconsnewmy {
  static const a = Icon(
    Icons.access_time_rounded,
    color: colorAssets.BLACK,
    size: 12,
  );

  static const b = Icon(
    Icons.dangerous,
    size: 12,
    color: colorAssets.GREEN,
  );

  static const c = Icon(
    Icons.abc,
    size: 34,
    color: colorAssets.RED,
  );

  static const d = Icon(
    Icons.abc_rounded,
    size: 34,
    color: colorAssets.GREEN,
  );

  static const e = Icon(
    Icons.adb_sharp,
    color: colorAssets.RED,
    size: 34,
  );
  static const f = Icon(
    Icons.access_time_filled_outlined,
    color: colorAssets.BLACK,
    size: 34,
  );

  static const g = Icon(Icons.abc);
}

// thies ay icons are defined with greate

// import 'package:tryapp/screens/add_video_camera/s_5_add_video_form/validationModel.dart';
// import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:add_video/components/add_Video/draft.dart';
import 'package:add_video/components/add_Video/model/add_video_data_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:add_video/components/add_Video/model/GeolocationModel.dart';
import 'package:add_video/components/add_Video/model/VideoDispRespModel.dart';
import 'package:add_video/constant/constant.dart';
import 'package:location/location.dart';

class add_video_provider with ChangeNotifier {
  // uid
  // address

  int _videoId = 0;
  String _Category = "";
  String _Genre = "";
  // String _title = "";
  String _Describe_experience = "";

  List<String> _pros = [];
  List<String> _cons = [];

  int _rate_experience = 0;

  String _Review_place = "";
  String _availability_shared = "";
  bool _draft = false;
//--------------   video list ---------------
  List<File> _allFileList = [];
  Uint8List? _bytes;
  File? _thumbnail;

  // -------------------  location ----------------------
  Location locationplugin = Location(); //object to fetch the location
  LocationData? _currentPosition; // x -y coordinates
  LocationData? _startPosition;
  GeolocationModel _cordin_to_address = GeolocationModel(
      country: "",
      district: "",
      location: "",
      pincode: "",
      place: "",
      state: "");
  String _path_to_files = "";
  List get getItems => [..._allFileList];

  bool _back = true;
  bool get getback => _back;

// set setback => !_back;
  set setback(value) {
    _back = value;
    notifyListeners();
  }

  bool shared_in_boolean(shared) {
    return shared == "private" ? true : false;
  }

  delete(index) {
    _allFileList.removeAt(index);
    notifyListeners();
  }

  addVideo(File video) {
    _allFileList.add(video);
  }

  String convert_cord_to_location() {
    return '${_cordin_to_address.place}, ${_cordin_to_address.location}, ${_cordin_to_address.district}, ${_cordin_to_address.state}, ${_cordin_to_address.country}, ${_cordin_to_address.pincode}';
  }

  String get getthumbnail {
    print(
        "${_thumbnail!.path}   =======================    inside get thumbnail function");
    return _thumbnail!.path;
  }

  get getimage_bytes => _bytes;
  LocationData? get get_startPosition => _startPosition;
  get get_cordin_to_address => convert_cord_to_location();

  // get get_like_about_place => _like_aboute_place;

  setValue({
    required String category,
    required String genre,
    //title
    required String Describe_experience,
    required List<String> pros,
    required List<String> cons,
    required String Review_place,
    required int rate_experience,
    required String availability_shared,
    required bool draft,
  }) {
    _Category = category;
    _Genre = genre;
    _Describe_experience = Describe_experience;
    _pros = pros;
    _cons = cons;
    _Review_place = Review_place;
    _rate_experience = rate_experience;
    _availability_shared = availability_shared;
    _draft = draft;

    notifyListeners();
    print([
      _Category,
      _Genre,
      _Describe_experience,
      _pros,
      _cons,
      _rate_experience,
      _availability_shared,
      _draft
    ]);
    print("saved succefully");
  }

  Future getFrame() async {
    if (_allFileList != null && _allFileList.isNotEmpty) {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: _allFileList[0].path,
        imageFormat: ImageFormat.PNG,
        quality: 100,
      );

      final file = File(thumbnailPath!);
      _bytes = file.readAsBytesSync();
      // final file = File(fileName!);

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/my_image.png';
      // final file2 = File(filePath);
      // await file2.writeAsBytes(_bytes!);

      // _thumbnail = file2;
      _thumbnail = File(filePath);
      await _thumbnail!.writeAsBytes(_bytes!);

      // _thumbnail = file2;

      print("set thumbnail $_thumbnail");
      notifyListeners();
    }
  }

  Future<void> get_current_coordinates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationplugin.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationplugin.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationplugin.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationplugin.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (_allFileList.isEmpty) {
      _startPosition = await locationplugin.getLocation();
    }
    _currentPosition = await locationplugin.getLocation();
    notifyListeners();
  }

  // void get_current_address() async {
  //   print("---------- inside  get_current_address");
  //    await fetch_Location(
  //       latitude: _startPosition!.latitude!,
  //       longitude: _startPosition!.longitude!);
  // }

  Future<bool> upload_video() async {
    await post_video_description();
    await post_video_file(
            thumbnails: _thumbnail!.path,
            videos: [..._allFileList],
            videoId: _videoId!,
            token: api.token_key)
        .then((value) {
      print("*  post_video_file response **************   $value");
      return true;
    });
    return false;
  }

  Future<bool> location_out_of_bound_check() async {
    await get_current_coordinates();
    return fetch_cord_measure(m1: _startPosition!, m2: _currentPosition!)
        .catchError((error) {
      print(error);
    });
  }

  Future<bool> save_draft_operation(context) async {
    try {
      draft classA = Provider.of<draft>(context, listen: false);
      _path_to_files =
          await classA.save_files_on_device_as_draft(_allFileList, _thumbnail!);

      await classA
          .adddraftData(
              Category: _Category,
              Genre: _Genre,
              Describe_experience: _Describe_experience,
              pros: _pros,
              cons: _cons,
              rate_experience: _rate_experience,
              Review_place: _Review_place,
              availability_shared: _availability_shared,
              start_lat: _startPosition!.latitude!,
              start_long: _startPosition!.longitude!,
              file_path: _path_to_files)
          .then((value) => print(" $value   =============   adddraftData "));
      return true;
    } catch (e) {
      print("$e  *****************************  error");
      return false;
    }
  }
  //////////////////     get distance  ////////////

  // num get_distance(double d1x, double d1y, double d2x, double d2y) {
  //   final Distance latlongGeography = Distance();

  //   final num distance_in_km = latlongGeography.as(
  //       LengthUnit.Kilometer, LatLng(d1x, d1y), LatLng(d2x, d2y));
  //   print(distance_in_km);

  //   return distance_in_km;
  // }

  ///    savedata to shareprefrences

  // static Future<add_video_data_model> getadd_video_data_modelList(  String add_video_data_modelListKey) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final add_video_data_modelListJson =
  //       prefs.getString(add_video_data_modelListKey);

  //   if (add_video_data_modelListJson == null) {
  //     return Future.value();
  //   }

  //   final add_video_data_modelList = json.decode(add_video_data_modelListJson);
  //   return add_video_data_model.fromJson(add_video_data_modelList);
  // }

  // static Future<void> saveadd_video_data_modelList(
  //     add_video_data_model add_video_data_modelList,
  //     String add_video_data_modelListKey) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final add_video_data_modelListJson = json.encode(add_video_data_modelList);
  //   await prefs.setString(
  //       add_video_data_modelListKey, add_video_data_modelListJson);
  // }

  // Future<void> fetch_Location(
  //     {required double latitude, required double longitude}) async {
  //   print("inside getLocation");
  //   var uri =
  //       '${api.baseUrl}${api.get_AddressFromCoordiates}lat=$latitude&long=$longitude';
  //   print(uri);

  //   final url = Uri.parse(uri);

  //   try {
  //     final response =
  //         await http.get(url, headers: {"accept": "application/json"});
  //     print(response.body);
  //     print("fetch_Location------------------------${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       _cordin_to_address = geolocationModelFromJson(response.body);
  //       notifyListeners();
  //       // return true;
  //     } else {
  //       throw "respose is not 200 but ${response.statusCode}";
  //     }
  //   } catch (error) {
  //     print("-------- $error");
  //     throw error;
  //     // return false;
  //     // throw error;
  //   }
  // }

  Future<bool> fetch_cord_measure(
      {required LocationData m1, required LocationData m2}) async {
    print("inside fetch_cord_measure");
    // var uri =
    //     '${api.baseUrl}${api.cord_measure}lat1=${m1.latitude}&long1=${m1.longitude}&lat2=${m2.latitude}&long2=${m1.longitude}';
    // print(uri);

    // final url = Uri.parse(uri);

    try {
      final Distance latlongGeography = Distance();

      final num distance_in_km = latlongGeography.as(LengthUnit.Kilometer,
          LatLng(m1.latitude, m1.longitude), LatLng(m2.latitude, m2.longitude));

      return Future.value(distance_in_km <= 1 ? true : false);
      // final response =
      //     await http.get(url, headers: {"accept": "application/json"});
      // print(response.body);
      // print(
      //     "fetch_cord_converting------------------------${response.statusCode}");

      // if (response.statusCode == 200) {
      //   Map _cord_measure = json.decode(response.body);

      //   return (_cord_measure["value"]);
      // }
      // return false;
    } catch (error) {
      print("-------- $error");

      throw error;

      // throw error;
    }
  }

  Future<void> post_video_description() async {
    final url = Uri.parse('${api.baseUrl}${api.add_video_description}');

    try {
      final response = await http.post(url,
          body: json.encode(
            {
              "uid": 2,
              "address": convert_cord_to_location(),
              "lat": _currentPosition!.latitude,
              "long": _currentPosition!.longitude,
              "category": _Category,
              "genre": _Genre,
              "review": _Review_place,
              "description": _Describe_experience,
              "pros": _pros,
              "cons": _cons,
              "rating": _rate_experience,
              "shared": shared_in_boolean(_availability_shared),
              "draft": _draft
            },
          ),
          headers: {"content-type": "application/json"});

      final responseData = json.decode(response.body);
      print(
          "$responseData  ---post_video_description-----${response.statusCode} ");

      if (response.statusCode == 201) {
        VideoDispRespModel resCovrtModel =
            videoDispRespModelFromJson(response.body);
        _videoId = resCovrtModel.videoId;

        print("seted vidceo id $_videoId");
      } else {
        throw Exception('Failed operatoin');
      }
    } catch (error) {
      // throw error;
      print(error);
    }
  }

  Future<bool> post_video_file(
      {required String thumbnails,
      required List<File> videos,
      required int videoId,
      required String token}) async {
    try {
      print(thumbnails);
      Map<String, String> headers = {
        "accept": "application/json",
        "Content-Type": "multipart/form-data"
      };

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "${api.baseUrl}${api.add_video_files}videoId=$videoId&token=$token&action=add"));

      List<http.MultipartFile> newList = [];
      for (int i = 0; i < videos.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath(
            'video', videos[i].path,
            contentType: MediaType('video', 'mp4'));

        newList.add(multipartFile);
      }
      request.files.addAll(newList);
      request.files.add(await http.MultipartFile.fromPath(
          'thumbnails', thumbnails,
          contentType: MediaType('image', 'png')));

      print("@@@@-----------> sending........");

      var response = await request.send();
      print(response.toString());

      response.stream.transform(utf8.decoder).listen((value) {
        print('value');
        print(value);
      });

      if (response.statusCode == 200) {
        print('uploaded');

        _allFileList.clear();
      } else {
        print('failed');
      }

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

// class FormProvider extends ChangeNotifier {
//   // ValidationModel _email = ValidationModel(null, null);
//   // ValidationModel _password = ValidationModel(null, null);
//   // ValidationModel _phone = ValidationModel(null, null);
//   ValidationModel _name = ValidationModel(null, null);
//   // ValidationModel get email => _email;
//   // ValidationModel get password => _password;
//   // ValidationModel get phone => _phone;
//   ValidationModel get name => _name;

//   // void validateEmail(String? val) {
//   //   if (val != null && val.isValidEmail) {
//   //     _email = ValidationModel(val, null);
//   //   } else {
//   //     _email = ValidationModel(null, 'Please Enter a Valid Email');
//   //   }
//   //   notifyListeners();
//   // }

//   // void validatePassword(String? val) {
//   //   if (val != null && val.isValidPassword) {
//   //     _password = ValidationModel(val, null);
//   //   } else {
//   //     _password = ValidationModel(null,
//   //         'Password must contain an uppercase, lowercase, numeric digit and special character');
//   //   }
//   //   notifyListeners();
//   // }

//   void validateName(String? val) {
//     if (val != null && val.isValidName) {
//       _name = ValidationModel(val, null);
//     } else {
//       _name = ValidationModel(null, 'Please enter a valid name');
//     }
//     notifyListeners();
//   }

//   // void validatePhone(String? val) {
//   //   if (val != null && val.isValidPhone) {
//   //     _phone = ValidationModel(val, null);
//   //   } else {
//   //     _phone = ValidationModel(null, 'Phone Number must be up to 11 digits');
//   //   }
//   //   notifyListeners();
//   // }

//   bool get validate {
//     return
//     // _email.value != null &&
//     //     _password.value != null &&
//     //     _phone.value != null &&
//         _name.value != null;
//   }
// }

// extension extString on String {
//   bool get isValidEmail {
//     // final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     return true;
//   }

//   bool get isValidName {
//     final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_]{7,29}$");
//     // final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
//     // return nameRegExp.hasMatch(this);
//     return true;
//   }

//   bool get isValidPassword {
//     final passwordRegExp = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

//     // final passwordRegExp = RegExp(
//     //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
//     // return passwordRegExp.hasMatch(this);
//     return true;

//   }

//   bool get isNotNull {
//     return this != null;
//   }

//   bool get isValidPhone {
//     final phoneRegExp =
//         RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$");
//     // final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
//     // return phoneRegExp.hasMatch(this);
//     return true;

//   }
// }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tryapp3/constant/constant.dart';
// import 'package:tryapp3/model/video_display_model.dart';
// import '../components/home/fetch_video_model.dart';
// import 'dart:convert';

// // import 'package:tryapp/temp1/bhaiya/s_5_add_video_form.dart';

// class video_provider with ChangeNotifier {
//   List<HomeVideo1> _items = [];
//   int _pageNumber = 0;
//   int _nextPageTrigger = 3;
//   int _end = 5;
//   int _start = 0;

//   get pageNumber => _pageNumber;
//   get nextPageTrigger => _nextPageTrigger;

//   setPageNumber(int n) {
//     _pageNumber = n;
//     notifyListeners();
//   }

//   setNextPageTrigger(int n) {
//     _nextPageTrigger = n;
//     notifyListeners();
//   }

//   List<HomeVideo1> get items {
//     return [..._items];
//   }

//   void addProduct() {
//     notifyListeners();
//   }

//   Future<void> getUsers() async {
//     try {
//       print("inside try");

//       var url =
//           Uri.parse(api.baseUrl + api.get_video + "&end=$_end&start=$_start");
//       var response = await http.get(url);
//       // print(" --------->   ${response.body}");
//       if (response.statusCode == 200) {
//         // _items = homeVideo1FromJson(response.body);
//         _items.addAll(homeVideo1FromJson(response.body));

//         print(
//             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${_items.length}");

//         // if (_start == 0) {
//         //   (_start = (_start + 1) * _pageNumber) - 1;
//         //   _end = _end * _pageNumber;
//         // } else {
//         //   _start = _start * _pageNumber;
//         //   _end = _end * _pageNumber;

//         // }
//         // _end += 5;
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

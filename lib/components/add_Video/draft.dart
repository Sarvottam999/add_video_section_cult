import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:add_video/components/add_Video/model/GeolocationModel.dart';
import 'package:add_video/components/add_Video/model/add_video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class draft extends ChangeNotifier {
  //========================= save file to files  ===========================
  ///
  Future<String> save_files_on_device_as_draft(
      List allFileList, File thumbnail) async {
    try {
      // Get the directory where we will save the image
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String videoDirPath = '${appDir.path}/video';

      // Create the "video" directory if it does not exist
      final Directory videoDir = Directory(videoDirPath);
      if (!await videoDir.exists()) {
        await videoDir.create();
      }
// ---------------------------------------------------------------------------
      void moveFile(String oldPath, String newPath) async {
        String oldPath_file_name = oldPath.split("/").last;

        final file = File(oldPath);

        await File(oldPath).rename(newPath + "/" + oldPath_file_name);

        // file.rename(newPath);
      }

      // Generate a unique folder name using the current timestamp
      final String folderName =
          DateTime.now().millisecondsSinceEpoch.toString();

      // Create a new folder inside the "video" folder
      final Directory newFolder =
          await Directory('$videoDirPath/$folderName').create();

      if (allFileList != null) {
        for (var i = 0; i < allFileList.length; i++) {
          moveFile(allFileList[i].path, newFolder.path);
        }
      }
      moveFile(thumbnail.path, newFolder.path);

      // notifyListeners();
      return newFolder.path;
    } catch (e) {
      print(e);
      return "null";
    }

    // Capture the image
    // final XFile? imageFile =
    //     await ImagePicker().pickImage(source: ImageSource.camera);
  }

  //================   draft ==============================

  List<add_video_data_model> _add_video_data_model_list = [];
  List<add_video_data_model> getDatafromshared() {
    return _add_video_data_model_list;
  }

// ================================================================  get list
  Future<void> loaddraftData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final draftDataListJson = prefs.getString('videos');
      print("$draftDataListJson ------------------ json ");

      // if (draftDataListJson != null) {
      //   final List<dynamic> add_video_data_model_list =
      //       jsonDecode(draftDataListJson);

      //   _add_video_data_model_list = add_video_data_model_list
      //       .map((e) => add_video_data_model.fromJson(e))
      //       .toList();

      //   notifyListeners();
      // }

      // print(
      //     "${_add_video_data_model_list[0].thumbnail}            ----------------  thubnail");

      // return _add_video_data_model_list;
    } catch (e) {
      print("$e     =========== in loaddraftData ");
      // return _add_video_data_model_list;
    }
  }
// ================================================================   save list

  void savedraftDataList() async {
    final prefs = await SharedPreferences.getInstance();
    final draftDataListJson =
        json.encode(_add_video_data_model_list.map((e) => e.toJson()).toList());
    await prefs.setString('videos', draftDataListJson);
  }

// ================================================================   add item

  Future<bool> adddraftData({
    required String Category,
    required String Genre,
    required String Describe_experience,
    required List<String> pros,
    required List<String> cons,
    required int rate_experience,
    required String Review_place,
    required String availability_shared,
    // -----------   thumbnail ---------------
    // required Uint8List bytes,
    required String file_path,
    // -----------------  location ----------------------
    required double start_lat,
    required double start_long,
    // required String cordin_to_address,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final draftDataListJson = prefs.getString('videos');

    if (draftDataListJson != null) {
      final List<dynamic> add_video_data_model_list =
          jsonDecode(draftDataListJson);

      _add_video_data_model_list = add_video_data_model_list
          .map((e) => add_video_data_model.fromJson(e))
          .toList();
    }
    // print(
    // "${thumbnailnew} //////////////////////////////////////////////////////");

    // if (city.isEmpty || condition.isEmpty) return;

    _add_video_data_model_list.add(add_video_data_model(
      Category: Category,
      Genre: Genre,
      Describe_experience: Describe_experience,
      pros: pros,
      cons: cons,
      rate_experience: rate_experience,
      Review_place: Review_place,
      availability_shared: availability_shared,
      // bytes: bytes,
      file_path: file_path,
      start_lat: start_lat,
      start_long: start_long,
      // cordin_to_address: cordin_to_address,
    ));

    print(_add_video_data_model_list.last);
    // print(Category);
    // print(thumbnailnew);
    // print(Describe_experience);
    // print(cordin_to_address);

    // ==============================================================

    savedraftDataList();
    notifyListeners();
    return true;
  }
// ================================================================   delete item

  void _deletedraftData(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final draftDataListJson = prefs.getString('videos');

    if (draftDataListJson != null) {
      final List<dynamic> add_video_data_model_list =
          jsonDecode(draftDataListJson);

      _add_video_data_model_list = add_video_data_model_list
          .map((e) => add_video_data_model.fromJson(e))
          .toList();
    }

    _add_video_data_model_list.removeAt(index);

    savedraftDataList();
    notifyListeners();
  }

  void clear_all_draft() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}

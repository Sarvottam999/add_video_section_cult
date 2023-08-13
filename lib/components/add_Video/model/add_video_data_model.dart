import 'dart:typed_data';

import 'package:add_video/components/add_Video/model/GeolocationModel.dart';
import 'package:location/location.dart';

class add_video_data_model {
  final String Category;
  final String Genre;
  final String Describe_experience;
  final List<String> pros;
  final List<String> cons;
  final int rate_experience;
  final String Review_place;
  final String availability_shared;
  //--------------   thumbnail ---------------
  // final Uint8List bytes;
  final String file_path;
  // -------------------  location ----------------------
  final double start_lat;
  final double start_long;

  // final LocationData? startPosition;
  // final String cordin_to_address;

  add_video_data_model(
      {required this.Category,
      required this.Genre,
      required this.Describe_experience,
      required this.pros,
      required this.cons,
      required this.rate_experience,
      required this.Review_place,
      required this.availability_shared,
      // required this.bytes,
      required this.file_path,
      required this.start_lat,
      required this.start_long,
      // required this.cordin_to_address
      });

  Map<String, dynamic> toJson() => {
        "Category": Category,
        "Genre": Genre,
        "Describe_experience": Describe_experience,
        "pros": List<String>.from(pros.map((x) => x)),
        "cons": List<String>.from(cons.map((x) => x)),
        "rate_experience": rate_experience,
        "Review_place": Review_place,
        "availability_shared": availability_shared,
        // "bytes": bytes,
        "file_path": file_path,
        "start_lat": start_lat,
        "start_long": start_long,
        // "cordin_to_address": cordin_to_address,
      };

  factory add_video_data_model.fromJson(Map<String, dynamic> json) {
    return add_video_data_model(
        Category: json["Category"],
        Genre: json["Genre,"],
        Describe_experience: json["Describe_experience"],
        pros: List<String>.from(json["pros"].map((x) => x)),
        cons: List<String>.from(json["cons"].map((x) => x)),
        rate_experience: json["rate_experience,"],
        Review_place: json["Review_place,"],
        availability_shared: json["availability_shared"],
        // bytes: json["bytes,"],
        file_path: json["file_path,"],
        start_lat: json["start_lat,"],
        start_long: json["start_long,"]

        // startPosition: json["startPosition,"],
        // cordin_to_address: json["cordin_to_address"]
        );
  }
}

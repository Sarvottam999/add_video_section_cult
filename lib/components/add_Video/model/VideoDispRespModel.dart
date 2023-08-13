// To parse this JSON data, do
//
//     final videoDispRespModel = videoDispRespModelFromJson(jsonString);

import 'dart:convert';

VideoDispRespModel videoDispRespModelFromJson(String str) => VideoDispRespModel.fromJson(json.decode(str));

String videoDispRespModelToJson(VideoDispRespModel data) => json.encode(data.toJson());

class VideoDispRespModel {
    int uid;
    int videoId;

    VideoDispRespModel({
        required this.uid,
        required this.videoId,
    });

    factory VideoDispRespModel.fromJson(Map<String, dynamic> json) => VideoDispRespModel(
        uid: json["uid"],
        videoId: json["videoId"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "videoId": videoId,
    };
}

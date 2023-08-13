// To parse this JSON data, do
//
//     final homeVideo1 = homeVideo1FromJson(jsonString);

import 'dart:convert';

List<HomeVideo1> homeVideo1FromJson(String str) => List<HomeVideo1>.from(json.decode(str).map((x) => HomeVideo1.fromJson(x)));

String homeVideo1ToJson(List<HomeVideo1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeVideo1 {
    HomeVideo1({
        required this.uid,
        required this.videoId,
        required this.url,
        required this.thumbUrl,
        required this.address,
        required this.lat,
        required this.long,
        required this.category,
        required this.genre,
        required this.title,
        required this.description,
        required this.pros,
        required this.cons,
        required this.rating,
        required this.shared,
        required this.draft,
        required this.views,
        required this.likes,
        required this.uploadTime,
    });

    int uid;
    int videoId;
    List<String> url;
    String thumbUrl;
    String address;
    double lat;
    double long;
    String category;
    String genre;
    String title;
    String description;
    String pros;
    String cons;
    double rating;
    bool shared;
    bool draft;
    int views;
    int likes;
    DateTime uploadTime;

    factory HomeVideo1.fromJson(Map<String, dynamic> json) => HomeVideo1(
        uid: json["uid"],
        videoId: json["videoId"],
        url: List<String>.from(json["url"].map((x) => x)),
        thumbUrl: json["thumbURL"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        category: json["category"],
        genre: json["genre"],
        title: json["title"],
        description: json["description"],
        pros: json["pros"],
        cons: json["cons"],
        rating: json["rating"],
        shared: json["shared"],
        draft: json["draft"],
        views: json["views"],
        likes: json["likes"],
        uploadTime: DateTime.parse(json["uploadTime"]),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "videoId": videoId,
        "url": List<dynamic>.from(url.map((x) => x)),
        "thumbURL": thumbUrl,
        "address": address,
        "lat": lat,
        "long": long,
        "category": category,
        "genre": genre,
        "title": title,
        "description": description,
        "pros": pros,
        "cons": cons,
        "rating": rating,
        "shared": shared,
        "draft": draft,
        "views": views,
        "likes": likes,
        "uploadTime": uploadTime.toIso8601String(),
    };
}

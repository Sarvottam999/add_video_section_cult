// To parse this JSON data, do
//
//     final geolocationModel = geolocationModelFromJson(jsonString);

import 'dart:convert';

GeolocationModel geolocationModelFromJson(String str) => GeolocationModel.fromJson(json.decode(str));

String geolocationModelToJson(GeolocationModel data) => json.encode(data.toJson());

class GeolocationModel {
    String location;
    String place;
    String district;
    String state;
    String country;
    String pincode;

    GeolocationModel({
        required this.location,
        required this.place,
        required this.district,
        required this.state,
        required this.country,
        required this.pincode,
    });

    factory GeolocationModel.fromJson(Map<String, dynamic> json) => GeolocationModel(
        location: json["location"],
        place: json["place"],
        district: json["district"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
    );

    Map<String, dynamic> toJson() => {
        "location": location,
        "place": place,
        "district": district,
        "state": state,
        "country": country,
        "pincode": pincode,
    };
}
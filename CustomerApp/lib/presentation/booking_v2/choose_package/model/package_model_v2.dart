// To parse this JSON data, do
//
//     final packageModelV2 = packageModelV2FromJson(jsonString);

import 'dart:convert';

List<PackageModelV2> packageModelV2FromJson(String str) =>
    List<PackageModelV2>.from(
        json.decode(str).map((x) => PackageModelV2.fromJson(x)));

String packageModelV2ToJson(List<PackageModelV2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PackageModelV2 {
  PackageModelV2({
     this.id="",
     this.name="",
     this.img="",
     this.startTime="",
     this.endTime="",
     this.slotStart=0,
     this.slotEnd=0,
     this.duration=0,
     this.price=0,
     this.healthStatus="",
     this.desc="",
     this.services,
  });

  String? id;
  String? name;
  String? img;
  String? startTime;
  String? endTime;
  int? slotStart;
  int? slotEnd;
  int? duration;
  double? price;
  String? healthStatus;
  String? desc;
  List<String>? services;

  factory PackageModelV2.fromJson(Map<String, dynamic> json) => PackageModelV2(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        slotStart: json["slotStart"],
        slotEnd: json["slotEnd"],
        duration: json["duration"],
        price: json["price"]?.toDouble(),
        healthStatus: json["healthStatus"],
        desc: json["desc"],
        services: List<String>.from(json["services"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "startTime": startTime,
        "endTime": endTime,
        "slotStart": slotStart,
        "slotEnd": slotEnd,
        "duration": duration,
        "price": price,
        "healthStatus": healthStatus,
        "desc": desc,
        "services": List<dynamic>.from(services!.map((x) => x)),
      };
}

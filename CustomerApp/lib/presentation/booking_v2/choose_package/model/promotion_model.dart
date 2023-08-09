// To parse this JSON data, do
//
//     final promotion = promotionFromJson(jsonString);

import 'dart:convert';

List<Promotion> promotionFromJson(String str) => List<Promotion>.from(json.decode(str).map((x) => Promotion.fromJson(x)));

String promotionToJson(List<Promotion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promotion {
    String id;
    String name;
    String? description;
    String image;
    double value;
    String startDate;
    String endDate;
    String code;
    String status;

    Promotion({
        required this.id,
        required this.name,
        this.description,
        required this.image,
        required this.value,
        required this.startDate,
        required this.endDate,
        required this.code,
        required this.status,
    });

    factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        value: json["value"]?.toDouble(),
        startDate: json["startDate"],
        endDate: json["endDate"],
        code: json["code"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "value": value,
        "startDate": startDate,
        "endDate": endDate,
        "code": code,
        "status": status,
    };
}

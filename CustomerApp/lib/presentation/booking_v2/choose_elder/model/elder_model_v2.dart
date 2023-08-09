// To parse this JSON data, do
//
//     final elderModelV2 = elderModelV2FromJson(jsonString);

import 'dart:convert';

List<ElderModelV2> elderModelV2FromJson(String str) => List<ElderModelV2>.from(json.decode(str).map((x) => ElderModelV2.fromJson(x)));

String elderModelV2ToJson(List<ElderModelV2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ElderModelV2 {
    ElderModelV2({
        required this.id,
        required this.fullName,
        required this.dob,
        required this.healthStatus,
        required this.gender,
    });

    String id;
    String fullName;
    DateTime dob;
    String healthStatus;
    String gender;

    factory ElderModelV2.fromJson(Map<String, dynamic> json) => ElderModelV2(
        id: json["id"],
        fullName: json["fullName"],
        dob: DateTime.parse(json["dob"]),
        healthStatus: json["healthStatus"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "healthStatus": healthStatus,
        "gender": gender,
    };
}

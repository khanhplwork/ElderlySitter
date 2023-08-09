// To parse this JSON data, do
//
//     final checkIncreaseEditting = checkIncreaseEdittingFromJson(jsonString);

import 'dart:convert';

CheckIncreaseEditting checkIncreaseEdittingFromJson(String str) => CheckIncreaseEditting.fromJson(json.decode(str));

String checkIncreaseEdittingToJson(CheckIncreaseEditting data) => json.encode(data.toJson());

class CheckIncreaseEditting {
    CheckIncreaseEditting({
        required this.isAdd,
        required this.dates,
        required this.maxDate,
    });

    bool isAdd;
    List<String> dates;
    String maxDate;

    factory CheckIncreaseEditting.fromJson(Map<String, dynamic> json) => CheckIncreaseEditting(
        isAdd: json["isAdd"],
        dates: List<String>.from(json["dates"].map((x) => x)),
        maxDate: json["maxDate"],
    );

    Map<String, dynamic> toJson() => {
        "isAdd": isAdd,
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "maxDate": maxDate,
    };
}

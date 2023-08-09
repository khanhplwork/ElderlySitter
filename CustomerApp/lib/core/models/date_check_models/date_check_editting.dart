// To parse this JSON data, do
//
//     final dateCheckEditing = dateCheckEditingFromJson(jsonString);

import 'dart:convert';

DateCheckEditing dateCheckEditingFromJson(String str) => DateCheckEditing.fromJson(json.decode(str));

String dateCheckEditingToJson(DateCheckEditing data) => json.encode(data.toJson());

class DateCheckEditing {
    DateCheckEditing({
        required this.isReduce,
        required this.dates,
        required this.numberOfReduce,
    });

    bool isReduce;
    List<String> dates;
    int numberOfReduce;

    factory DateCheckEditing.fromJson(Map<String, dynamic> json) => DateCheckEditing(
        isReduce: json["isReduce"],
        dates: List<String>.from(json["dates"].map((x) => x)),
        numberOfReduce: json["numberOfReduce"],
    );

    Map<String, dynamic> toJson() => {
        "isReduce": isReduce,
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "numberOfReduce": numberOfReduce,
    };
}

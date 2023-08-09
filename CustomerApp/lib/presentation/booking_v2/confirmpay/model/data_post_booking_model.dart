// To parse this JSON data, do
//
//     final dataPostBooking = dataPostBookingFromJson(jsonString);

import 'dart:convert';

DataPostBooking dataPostBookingFromJson(String str) => DataPostBooking.fromJson(json.decode(str));

String dataPostBookingToJson(DataPostBooking data) => json.encode(data.toJson());

class DataPostBooking {
    DataPostBooking({
        required this.address,
        required this.place,
        required this.startDate,
        required this.endDate,
        required this.description,
        required this.elderId,
        required this.customerId,
        required this.packageId,
        required this.dates,
        required this.startTime,
         this.lat=0,
         this.lng=0,
         this.promotion="",
         required this.district
    });

    String address;
    String place;
    String startDate;
    String endDate;
    String description;
    String elderId;
    String customerId;
    String packageId;
    List<String> dates;
    String startTime;
    double? lat;
    double? lng;
    String promotion;
    String district;

    factory DataPostBooking.fromJson(Map<String, dynamic> json) => DataPostBooking(
        address: json["address"],
        place: json["place"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        elderId: json["elderId"],
        customerId: json["customerId"],
        packageId: json["packageId"],
        dates: List<String>.from(json["dates"].map((x) => x)),
        startTime: json["startTime"],
        district:json["district"]
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "place": place,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "elderId": elderId,
        "customerId": customerId,
        "packageId": packageId,
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "startTime": startTime,
        "promotion":promotion,
        "district":district
    };
}

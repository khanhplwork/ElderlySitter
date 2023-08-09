// To parse this JSON data, do
//
//     final checkPriceModel = checkPriceModelFromJson(jsonString);

import 'dart:convert';

CheckPriceModel checkPriceModelFromJson(String str) => CheckPriceModel.fromJson(json.decode(str));

String checkPriceModelToJson(CheckPriceModel data) => json.encode(data.toJson());

class CheckPriceModel {
    CheckPriceModel({
        required this.datePriceInform,
        required this.totalPrice,
        required this.discountPrice,
        required this.afterDiscountPrice
    });

    DatePriceInform datePriceInform;
    double totalPrice;
    double discountPrice;
    double afterDiscountPrice;

    factory CheckPriceModel.fromJson(Map<String, dynamic> json) => CheckPriceModel(
        datePriceInform: DatePriceInform.fromJson(json["datePriceInform"]),
        totalPrice: json["totalPrice"]?.toDouble(),
        discountPrice: json["discountPrice"]!=null?json["discountPrice"].toDouble():0,
        afterDiscountPrice:json["afterDiscountPrice"]!=null?json["afterDiscountPrice"].toDouble():0
    );

    Map<String, dynamic> toJson() => {
        "datePriceInform": datePriceInform.toJson(),
        "totalPrice": totalPrice,
    };
}

class DatePriceInform {
    DatePriceInform({
         this.midnight,
         this.weekend,
         this.normal,
         this.holiday,
    });

    TypeDay? midnight;
    TypeDay? weekend;
    TypeDay? normal;
    TypeDay? holiday;

    factory DatePriceInform.fromJson(Map<String, dynamic> json) => DatePriceInform(
        midnight: json["MIDNIGHT"]!=null?TypeDay.fromJson(json["MIDNIGHT"]):null,
        weekend: json["WEEKEND"]!=null?TypeDay.fromJson(json["WEEKEND"]):null,
        normal: json["NORMAL"]!=null?TypeDay.fromJson(json["NORMAL"]):null,
        holiday: json["HOLIDAY"]!=null?TypeDay.fromJson(json["HOLIDAY"]):null,
    );

    Map<String, dynamic> toJson() => {
        "MIDNIGHT": midnight?.toJson(),
        "WEEKEND": weekend?.toJson(),
        "NORMAL": normal?.toJson(),
        "HOLIDAY": holiday?.toJson(),
    };
}

class TypeDay {
    TypeDay({
        required this.date,
        required this.percent,
        required this.price,
    });

    int date;
    double percent;
    double price;

    factory TypeDay.fromJson(Map<String, dynamic> json) => TypeDay(
        date: json["date"],
        percent: json["percent"]?.toDouble(),
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "percent": percent,
        "price": price,
    };
}

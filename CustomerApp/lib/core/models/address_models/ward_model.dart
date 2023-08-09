import 'dart:convert';

WardModel wardModelFromJson(String str) => WardModel.fromJson(json.decode(str));

String wardModelToJson(WardModel data) => json.encode(data.toJson());

class WardModel {
  WardModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<Datum> data;

  factory WardModel.fromJson(Map<String, dynamic> json) => WardModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.provinceCode,
  });

  String name;
  int code;
  String codename;
  String divisionType;
  int provinceCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    code: json["code"],
    codename: json["codename"],
    divisionType: json["division_type"],
    provinceCode: json["province_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "codename": codename,
    "division_type": divisionType,
    "province_code": provinceCode,
  };
}


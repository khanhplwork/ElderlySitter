import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  Data data;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.name,
    required this.code,
    required this.codename,
    required this.divisionType,
    required this.phoneCode,
  });

  String name;
  int code;
  String codename;
  String divisionType;
  int phoneCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    code: json["code"],
    codename: json["codename"],
    divisionType: json["division_type"],
    phoneCode: json["phone_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "codename": codename,
    "division_type": divisionType,
    "phone_code": phoneCode,
  };
}
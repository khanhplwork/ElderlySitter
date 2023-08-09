import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  DistrictModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<Datum> data;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
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
  Codename codename;
  String divisionType;
  int provinceCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    code: json["code"],
    codename: codenameValues.map[json["codename"]]!,
    divisionType: json["division_type"],
    provinceCode: json["province_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "codename": codenameValues.reverse[codename],
    "division_type": divisionType,
    "province_code": provinceCode,
  };
}

enum Codename { QUN, HUYN }

final codenameValues = EnumValues({
  "huyện": Codename.HUYN,
  "quận": Codename.QUN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

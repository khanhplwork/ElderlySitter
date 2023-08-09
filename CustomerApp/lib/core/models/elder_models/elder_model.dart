import 'package:elscus/core/models/elder_models/elder_data_model.dart';

class ElderModel {
  ElderModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<ElderDataModel> data;

  factory ElderModel.fromJson(Map<String, dynamic> json) => ElderModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<ElderDataModel>.from(json["data"].map((x) => ElderDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
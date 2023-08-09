import 'package:elscus/core/models/elder_models/elder_check_data_model.dart';

class CheckElderModel {
  CheckElderModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  ElderCheckDataModel data;

  factory CheckElderModel.fromJson(Map<String, dynamic> json) => CheckElderModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: ElderCheckDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}
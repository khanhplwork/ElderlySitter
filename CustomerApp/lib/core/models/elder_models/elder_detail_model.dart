import 'package:elscus/core/models/elder_models/elder_detail_data_model.dart';

class ElderDetailModel {
  ElderDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  ElderDetailDataModel data;

  factory ElderDetailModel.fromJson(Map<String, dynamic> json) => ElderDetailModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: ElderDetailDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}
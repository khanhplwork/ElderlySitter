import 'package:elscus/core/models/cus_models/cus_detail_data_model.dart';

class CusDetailModel {
  CusDetailModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  CusDetailDataModel data;

  factory CusDetailModel.fromJson(Map<String, dynamic> json) => CusDetailModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: CusDetailDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": data.toJson(),
  };
}
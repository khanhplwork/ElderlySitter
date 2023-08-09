import 'package:elscus/core/models/promotion_models/promotion_data_model.dart';

class PromotionModel {
  PromotionModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<PromotionDataModel> data;

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<PromotionDataModel>.from(json["data"].map((x) => PromotionDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
import 'package:elscus/core/models/package_service_models/package_service_data_model.dart';

class PackageServiceModel {
  PackageServiceModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<PackageServiceDataModel> data;

  factory PackageServiceModel.fromJson(Map<String, dynamic> json) => PackageServiceModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<PackageServiceDataModel>.from(json["data"].map((x) => PackageServiceDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

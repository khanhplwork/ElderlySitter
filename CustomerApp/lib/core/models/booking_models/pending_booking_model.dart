
import 'package:elscus/core/models/booking_models/pending_booking_data_model.dart';

class PendingBookingModel {
  PendingBookingModel({
    required this.successCode,
    this.errorCode,
    required this.data,
  });

  String successCode;
  dynamic errorCode;
  List<PendingBookingDataModel> data;

  factory PendingBookingModel.fromJson(Map<String, dynamic> json) => PendingBookingModel(
    successCode: json["successCode"],
    errorCode: json["errorCode"],
    data: List<PendingBookingDataModel>.from(json["data"].map((x) => PendingBookingDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "successCode": successCode,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
import 'package:elscus/core/models/booking_models/elder_dto.dart';
import 'package:elscus/core/models/booking_models/sitter_dto.dart';

class BookingHistoryDataModel {
  BookingHistoryDataModel({
    required this.id,
    required this.address,
    required this.createDate,
    required this.status,
    required this.elderDto,
    required this.totalPrice,
    required this.sitter,
    required this.startDate,
    required this.endDate,
  });

  String id;
  String address;
  DateTime createDate;
  String status;
  ElderDto elderDto;
  double totalPrice;
  SitterDto? sitter;
  DateTime startDate;
  DateTime endDate;

  factory BookingHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      BookingHistoryDataModel(
        id: json["id"],
        address: json["address"],
        createDate: DateTime.parse(json["createDate"]),
        status: json["status"],
        elderDto: ElderDto.fromJson(json["elderDTO"]),
        totalPrice: json["totalPrice"],
        sitter:(json["sitterDTO"] != null) ? SitterDto.fromJson(json["sitterDTO"]) : null,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "createDate":
            "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "elderDTO": elderDto,
        "totalPrice": totalPrice,
      };
}

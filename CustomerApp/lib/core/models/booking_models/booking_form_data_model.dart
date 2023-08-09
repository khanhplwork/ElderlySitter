import 'add_booking_detail_dto.dart';

class BookingDataModel {
  BookingDataModel({
    required this.address,
    required this.place,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.elderId,
    required this.customerId,
    required this.packageId,
    required this.addBookingDetailDtos,
  });

  String address;
  String place;
  String startDate;
  String endDate;
  String description;
  String elderId;
  String customerId;
  String packageId;
  List<AddBookingDetailDto> addBookingDetailDtos;

  factory BookingDataModel.fromJson(Map<String, dynamic> json) =>
      BookingDataModel(
        address: json["address"],
        place: json["place"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        elderId: json["elderId"],
        customerId: json["customerId"],
        packageId: json["packageId"],
        addBookingDetailDtos: List<AddBookingDetailDto>.from(
            json["addBookingDetailDTOS"]
                .map((x) => AddBookingDetailDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "place": place,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
        "elderId": elderId,
        "customerId": customerId,
        "packageId": packageId,
        "addBookingDetailDTOS":
            List<dynamic>.from(addBookingDetailDtos.map((x) => x.toJson())),
      };

}

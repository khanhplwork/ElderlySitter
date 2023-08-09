class PendingBookingDataModel {
  PendingBookingDataModel({
    required this.id,
    required this.address,
    required this.place,
    required this.createDate,
    required this.status,
    required this.totalPrice,
  });

  String id;
  String address;
  String place;
  String createDate;
  String status;
  double totalPrice;

  factory PendingBookingDataModel.fromJson(Map<String, dynamic> json) => PendingBookingDataModel(
    id: json["id"],
    address: json["address"],
    place: json["place"],
    createDate: json["createDate"],
    status: json["status"],
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "place": place,
    "createDate": createDate,
    "status": status,
    "totalPrice": totalPrice,
  };
}
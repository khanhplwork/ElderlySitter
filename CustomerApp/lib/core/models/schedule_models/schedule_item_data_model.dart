class ScheduleItemDataModel {
  ScheduleItemDataModel({
    required this.bookingId,
    required this.bookingDetailId,
    this.sitterName,
    required this.startDateTime,
    required this.endDateTime,
    required this.bookingStatus,
    required this.bookingDetailStatus,
  });

  String bookingId;
  String bookingDetailId;
  dynamic sitterName;
  String startDateTime;
  String endDateTime;
  String bookingStatus;
  String bookingDetailStatus;

  factory ScheduleItemDataModel.fromJson(Map<String, dynamic> json) =>
      ScheduleItemDataModel(
        bookingId: json["bookingId"],
        bookingDetailId: json["bookingDetailId"],
        sitterName: json["sitterName"],
        startDateTime: json["startDateTime"],
        endDateTime: json["endDateTime"],
        bookingStatus: json["bookingStatus"],
        bookingDetailStatus: json["bookingDetailStatus"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "bookingDetailId": bookingDetailId,
        "sitterName": sitterName,
        "startDateTime": startDateTime,
        "endDateTime": endDateTime,
        "bookingStatus": bookingStatus,
        "bookingDetailStatus": bookingDetailStatus,
      };
}

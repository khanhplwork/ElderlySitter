class AddBookingDetailDto {
  AddBookingDetailDto({
    required this.estimateTime,
    required this.image,
    required this.startDateTime,
    required this.endDateTime,
  });

  int estimateTime;
  String image;
  String startDateTime;
  String endDateTime;

  factory AddBookingDetailDto.fromJson(Map<String, dynamic> json) => AddBookingDetailDto(
    estimateTime: json["estimateTime"],
    image: json["image"],
    startDateTime: json["startDateTime"],
    endDateTime: json["endDateTime"],
  );

  Map<String, dynamic> toJson() => {
    "estimateTime": estimateTime,
    "image": image,
    "startDateTime": startDateTime,
    "endDateTime": endDateTime,
  };
  @override
  String toString() {
    // TODO: implement toString
    return "estimateTime: $estimateTime, image: $image, startDateTime: $startDateTime, endDateTime: $estimateTime";
  }
}
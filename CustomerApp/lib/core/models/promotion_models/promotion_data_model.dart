class PromotionDataModel {
  PromotionDataModel({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.code,
    required this.status,
  });

  String id;
  String name;
  String description;
  dynamic image;
  double value;
  String startDate;
  String endDate;
  String code;
  String status;

  factory PromotionDataModel.fromJson(Map<String, dynamic> json) =>
      PromotionDataModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        value: json["value"]?.toDouble(),
        startDate: json["startDate"],
        endDate: json["endDate"],
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "value": value,
        "startDate": startDate,
        "endDate": endDate,
        "code": code,
        "status": status,
      };
}

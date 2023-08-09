class PackageServiceDataModel {
  PackageServiceDataModel({
    required this.id,
    required this.name,
    this.img,
    this.duration,
    required this.price,
    required this.desc,
    required this.status,
  });

  String id;
  String name;
  dynamic img;
  int? duration;
  double price;
  String desc;
  String status;

  factory PackageServiceDataModel.fromJson(Map<String, dynamic> json) => PackageServiceDataModel(
    id: json["id"],
    name: json["name"],
    img: json["img"],
    duration: json["duration"],
    price: json["price"],
    desc: json["desc"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "img": img,
    "duration": duration,
    "price": price,
    "desc": desc,
    "status": status,
  };
}
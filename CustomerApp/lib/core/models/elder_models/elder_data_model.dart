class ElderDataModel {
  ElderDataModel({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
  });

  String id;
  String fullName;
  DateTime dob;
  String gender;
  factory ElderDataModel.fromJson(Map<String, dynamic> json) => ElderDataModel(
    id: json["id"],
    fullName: json["fullName"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
  };
}
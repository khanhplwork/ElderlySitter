class ElderDetailDataModel {
  ElderDetailDataModel({
    required this.fullName,
    required this.dob,
    required this.healthStatus,
    required this.note,
    required this.gender,
    required this.idCardNumber,
  });

  String fullName;
  String dob;
  String healthStatus;
  String note;
  String gender;
  String idCardNumber;

  factory ElderDetailDataModel.fromJson(Map<String, dynamic> json) =>
      ElderDetailDataModel(
        fullName: json["fullName"],
        dob: json["dob"],
        healthStatus: json["healthStatus"],
        note: json["note"],
        gender: json["gender"],
        idCardNumber: (json["idCardNumber"] != null) ? json["idCardNumber"] : "",
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "dob": dob,
        "healthStatus": healthStatus,
        "note": note,
        "gender": gender,
        "idCardNumber": idCardNumber,
      };
}

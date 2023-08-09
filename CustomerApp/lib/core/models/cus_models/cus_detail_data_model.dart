class CusDetailDataModel {
  CusDetailDataModel(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phone,
      required this.address,
      required this.gender,
      required this.status,
      required this.dob,
      required this.avatarImgUrl,
      required this.backCardImgUrl,
      required this.frontCardImgUrl,
      this.createDate,
      required this.description,
      required this.idCardNumber,
      this.latitude = 0,
      this.longitude = 0,
      this.zone = ""});

  String id;
  String fullName;
  String email;
  String phone;
  String address;
  String gender;
  String status;
  String dob;
  String avatarImgUrl;
  String backCardImgUrl;
  String frontCardImgUrl;
  dynamic createDate;
  String description;
  String idCardNumber;
  double latitude;
  double longitude;
  String zone;

  factory CusDetailDataModel.fromJson(Map<String, dynamic> json) =>
      CusDetailDataModel(
        id: json["id"],
        fullName: (json["fullName"] != null) ? json["fullName"] : "",
        email: (json["email"] != null) ? json["email"] : "",
        phone: (json["phone"] != null) ? json["phone"] : "",
        address: (json["address"] != null) ? json["address"] : "",
        gender: (json["gender"] != null) ? json["gender"] : "",
        status: (json["status"] != null) ? json["status"] : "",
        dob: (json["dob"] != null) ? json["dob"] : "",
        avatarImgUrl: (json["avatar"] != null) ? json["avatar"] : "",
        backCardImgUrl:
            (json["backCardImgUrl"] != null) ? json["backCardImgUrl"] : "",
        frontCardImgUrl:
            (json["frontCardImgUrl"] != null) ? json["frontCardImgUrl"] : "",
        createDate: (json["createDate"] != null) ? json["createDate"] : "",
        description: (json["description"] != null) ? json["description"] : "",
        idCardNumber:
            (json["idCardNumber"] != null) ? json["idCardNumber"] : "",
        latitude: (json["latitude"] != null) ? json["latitude"].toDouble() : 0,
        longitude:
            (json["longitude"] != null) ? json["longitude"].toDouble() : 0,
        zone: (json["zone"] != null) ? json["zone"] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "address": address,
        "gender": gender,
        "status": status,
        "dob": dob,
        "avatarImgUrl": avatarImgUrl,
        "backCardImgUrl": backCardImgUrl,
        "frontCardImgUrl": frontCardImgUrl,
        "createDate": createDate,
        "description": description,
        "idCardNumber": idCardNumber,
        "latitude": latitude,
        "longitude": longitude,
        "zone": zone,
      };
  bool checkFullInfo() {
    if (id.isNotEmpty &&
        fullName.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        gender.isNotEmpty &&
        dob.isNotEmpty &&
        idCardNumber.isNotEmpty) {
      return true;
    }
    return false;
  }
}

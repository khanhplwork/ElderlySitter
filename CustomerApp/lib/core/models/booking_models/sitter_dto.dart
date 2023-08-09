import 'package:elscus/core/constants/image_constant.dart';

class SitterDto {
  SitterDto({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.status,
    required this.image,
    required this.age,
    required this.rate,
  });

  String id;
  String fullName;
  String phone;
  String email;
  String address;
  String gender;
  String status;
  String image;
  int age;
  double rate;

  factory SitterDto.fromJson(Map<String, dynamic> json) => SitterDto(
        id: json["id"],
        fullName: json["fullName"],
        phone: json["phone"],
        email: json["email"],
        address: (json["address"] != null) ? json["address"] : "",
        gender: json["gender"],
        status: json["status"],
        image:
            (json["image"] != null) ? json["image"] : ImageConstant.defaultAva,
        age: (json["age"] != null) ? json["age"] : 0,
        rate: (json["rate"] != null) ? json["rate"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "phone": phone,
        "email": email,
        "address": address,
        "gender": gender,
        "status": status,
        "image": image,
      };
}

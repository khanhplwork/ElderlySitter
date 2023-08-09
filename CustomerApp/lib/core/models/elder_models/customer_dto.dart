class CustomerDto {
  CustomerDto({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    this.status,
  });

  String id;
  String fullName;
  String phone;
  String email;
  String address;
  String gender;
  dynamic status;

  factory CustomerDto.fromJson(Map<String, dynamic> json) => CustomerDto(
    id: json["id"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    gender: json["gender"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "address": address,
    "gender": gender,
    "status": status,
  };
}
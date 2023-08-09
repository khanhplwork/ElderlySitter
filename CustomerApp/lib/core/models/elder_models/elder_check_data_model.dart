import 'customer_dto.dart';
class ElderCheckDataModel {
  ElderCheckDataModel({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.healthStatus,
    required this.customerDtoList,
  });

  String id;
  String fullName;
  String dob;
  String gender;
  String healthStatus;
  List<CustomerDto> customerDtoList;

  factory ElderCheckDataModel.fromJson(Map<String, dynamic> json) => ElderCheckDataModel(
    id: json["id"],
    fullName: json["fullName"],
    dob: json["dob"],
    gender: json["gender"],
    healthStatus: json["healthStatus"],
    customerDtoList: List<CustomerDto>.from(json["customerDTOList"].map((x) => CustomerDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "dob": dob,
    "gender": gender,
    "healthStatus": healthStatus,
    "customerDTOList": List<dynamic>.from(customerDtoList.map((x) => x.toJson())),
  };
}
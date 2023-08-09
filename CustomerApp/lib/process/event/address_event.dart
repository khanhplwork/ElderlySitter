abstract class AddressEvent {}

class OtherAddressEvent extends AddressEvent {}

class GetProvinceEvent extends AddressEvent {}

class GetDistrictEvent extends AddressEvent {}

class GetWardEvent extends AddressEvent{
  GetWardEvent({required this.district});
  final String district;
}
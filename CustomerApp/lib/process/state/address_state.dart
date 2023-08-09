import 'package:elscus/core/models/address_models/district_model.dart';
import 'package:elscus/core/models/address_models/ward_model.dart';

import '../../core/models/address_models/province_model.dart';

abstract class AddressState{}
class OtherAddressState extends AddressState{}
class GetProvinceState extends AddressState{
  GetProvinceState({required this.listProvince});
  final ProvinceModel listProvince;
}
class GetDistrictState extends AddressState{
  GetDistrictState({required this.listDistrict});
  final DistrictModel listDistrict;
}

class GetWardState extends AddressState{
  GetWardState({required this.listWard});
  final WardModel listWard;
}
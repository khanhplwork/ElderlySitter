import 'package:elscus/core/models/cus_models/cus_detail_data_model.dart';
import 'package:flutter/Material.dart';

abstract class CusState{}
class CusOtherState extends CusState{}
class CusDobState extends CusState{
  CusDobState({required this.dobController});
  final TextEditingController dobController;
}

class CusDetailState extends CusState{
  CusDetailState({required this.cusInfo});
  CusDetailDataModel cusInfo;
}
class TickIsCommitState extends CusState{
  TickIsCommitState({required this.isCommit});
  bool isCommit;
}
class UpdateAddressState extends CusState {
}

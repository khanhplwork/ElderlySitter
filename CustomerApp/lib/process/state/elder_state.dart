
import 'package:elscus/core/models/elder_models/elder_check_data_model.dart';
import 'package:elscus/core/models/elder_models/elder_detail_model.dart';
import 'package:elscus/core/models/elder_models/elder_model.dart';
import 'package:flutter/Material.dart';

abstract class ElderState{}
class OtherElderState extends ElderState{}
class ElderDobState extends ElderState{
  ElderDobState({required this.dobController});
  final TextEditingController dobController;
}

class ElderOtherState extends ElderState{
}

class GetAllElderState extends ElderState{
  GetAllElderState({required this.elderList});
  final ElderModel elderList;
}
class GetByHealthStatusElderState extends ElderState{
  GetByHealthStatusElderState({required this.elderList});
  final ElderModel elderList;
}
class ElderDetailState extends ElderState{
  ElderDetailState({required this.elder});
  final ElderDetailModel elder;
}
class GetCheckDataElderState extends ElderState{
  GetCheckDataElderState({required this.elderCheckData});
  final ElderCheckDataModel elderCheckData;
}

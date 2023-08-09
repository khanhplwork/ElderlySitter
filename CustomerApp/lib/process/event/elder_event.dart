
import 'package:flutter/Material.dart';

abstract class ElderEvent {}
class OtherElderEvent extends ElderEvent{}

class ChooseElderGenderEvent extends ElderEvent {
  ChooseElderGenderEvent({required this.gender});

  final String gender;
}

class ChooseElderHeathStatusEvent extends ElderEvent {
  ChooseElderHeathStatusEvent({required this.healthStatus});

  final String healthStatus;
}

class FillElderFullNameEvent extends ElderEvent {
  FillElderFullNameEvent({required this.fullName});

  final String fullName;
}

class ChooseElderDOBEvent extends ElderEvent {
  ChooseElderDOBEvent({required this.dob});

  final String dob;
}

class FillIDCardNumberEvent extends ElderEvent{
  FillIDCardNumberEvent({required this.idNumber});
  final String idNumber;
}

class AddNewElderEvent extends ElderEvent {
  AddNewElderEvent({required this.context});

  final BuildContext context;
}

class GetAllElderEvent extends ElderEvent {
  GetAllElderEvent();
}

class GetElderDetailDataEvent extends ElderEvent {
  GetElderDetailDataEvent({required this.elderID});

  final String elderID;
}

class UpdateElderEvent extends ElderEvent {
  UpdateElderEvent({required this.elderID, required this.context});
  final String elderID;
  final BuildContext context;
}

class DeleteElderEvent extends ElderEvent{
  DeleteElderEvent({required this.elderID, required this.context});
  final String elderID;
  final BuildContext context;
}

class GetByHealthStatusElderEvent extends ElderEvent{
  GetByHealthStatusElderEvent({required this.healthStatus});
  String healthStatus;
}
class GetCheckDataElderEvent extends ElderEvent{
  GetCheckDataElderEvent({required this.idNumber});
  final String idNumber;
}
class AddRelationElderEvent extends ElderEvent{
  AddRelationElderEvent({required this.context, required this.elderID});
  final BuildContext context;
  final String elderID;
}
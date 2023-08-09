

import 'package:flutter/Material.dart';

abstract class CusEvent{}

class FillFullnameCusEvent extends CusEvent{
  FillFullnameCusEvent({required this.fullname});
  final String fullname;
}
class FillPhoneNumberCusEvent extends CusEvent{
  FillPhoneNumberCusEvent({required this.phoneNumber});
  final String phoneNumber;
}
class FillIDNumberCusEvent extends CusEvent{
  FillIDNumberCusEvent({required this.idNumber});
  final String idNumber;
}
class FillEmailCusEvent extends CusEvent{
  FillEmailCusEvent({required this.email});
  final String email;
}
class FillPasswordCusEvent extends CusEvent{
  FillPasswordCusEvent({required this.password});
  final String password;
}
class FillRePasswordCusEvent extends CusEvent{
  FillRePasswordCusEvent({required this.rePassword});
  final String rePassword;
}
class ChooseGenderCusEvent extends CusEvent{
  ChooseGenderCusEvent({required this.gender});
  final String gender;
}
class ChooseDobCusEvent extends CusEvent{
  ChooseDobCusEvent({required this.dob});
  final String dob;
}
class FillAddressCusEvent extends CusEvent{
  FillAddressCusEvent({required this.address});
  final String address;
}
class UpdateInfoCusEvent extends CusEvent{
  UpdateInfoCusEvent({required this.context});
  final BuildContext context;
}

class GetInfoCusEvent extends CusEvent{
  GetInfoCusEvent();
}

class SignUpCusEvent extends CusEvent{
  SignUpCusEvent({required this.context});
  final BuildContext context;
}

class InitCusDataCusEvent extends CusEvent{

}

class ChooseAvaImageCusEvent extends CusEvent{
  ChooseAvaImageCusEvent({required this.avaUrl});
  String avaUrl;
}

class TickIsCommitEvent extends CusEvent{
}
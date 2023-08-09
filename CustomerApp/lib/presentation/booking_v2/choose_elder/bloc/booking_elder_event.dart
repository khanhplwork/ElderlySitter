import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:flutter/Material.dart';

abstract class BookingElderEvent {}

class OtherBookingElderEvent extends BookingElderEvent {}
class FetchDataEvent extends BookingElderEvent{}
class ClickSubmitElderEvent extends BookingElderEvent{
  ClickSubmitElderEvent({required this.context,required this.elder});
  ElderModelV2 elder;
  BuildContext context;
}
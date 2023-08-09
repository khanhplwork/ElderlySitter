import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:flutter/Material.dart';

abstract class BookingInputInforEvent{}

class OtherBookingInputInforEvent extends BookingInputInforEvent{}

class ClickOpenFormPickTimeEvent extends BookingInputInforEvent{
  ClickOpenFormPickTimeEvent({required this.context,required this.bookingInputBloc});
  BuildContext context;
  BookingInputInforBloc bookingInputBloc;
}
class UpdateEvent extends BookingInputInforEvent{}

class ClickOpenFormPickAddressEvent extends BookingInputInforEvent{
 ClickOpenFormPickAddressEvent({required this.context,required this.bookingInputBloc});
  BuildContext context;
  BookingInputInforBloc bookingInputBloc;
}
class FetchSlotDataEvent extends BookingInputInforEvent{
}
class PickSlotEvent extends BookingInputInforEvent{
  PickSlotEvent({required this.slotPicked});
  SlotDataModel slotPicked;
}
class ClickMultiPick  extends BookingInputInforEvent{}
class ClickRangePick  extends BookingInputInforEvent{}
class ClickCheckPrice  extends BookingInputInforEvent{
  ClickCheckPrice({this.isUpdate=false,this.dateUpdate=const [],this.startTime=""});
  bool isUpdate;
  List<String> dateUpdate;
  String startTime;
}



import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:flutter/Material.dart';

abstract class UpdateBookingEvent{}

class OtherUpdateBookingEvent extends UpdateBookingEvent{}
class CheckUpdateBookingEvent extends UpdateBookingEvent{
  CheckUpdateBookingEvent({required this.isReduce});
  bool isReduce;
}
//
class CheckReduceEvent extends UpdateBookingEvent{
  CheckReduceEvent({required this.context});
  BuildContext context;
}
class CheckIncreaseEvent extends UpdateBookingEvent{
  CheckIncreaseEvent({required this.context});
  BuildContext context;
}
class ClickChangeReduceEvent extends UpdateBookingEvent{
  ClickChangeReduceEvent({required this.context,required this.listDates});
  BuildContext context;
  List<DateTime?> listDates;
}

class ClickChangeIncreaseEvent extends UpdateBookingEvent{
  ClickChangeIncreaseEvent({required this.context,required this.listDates});
  BuildContext context;
  List<DateTime?> listDates;
}

class ClickUpdate extends UpdateBookingEvent{
  ClickUpdate({required this.context});
  BuildContext context;
}
class ClickUpdateIncrease extends UpdateBookingEvent{
  ClickUpdateIncrease({required this.context,required this.bookingFull});
  BuildContext context;
  BookingFullDetailDataModel bookingFull;
}

class CheckChangeDate extends UpdateBookingEvent{

}
//ClickUpdateIncrease
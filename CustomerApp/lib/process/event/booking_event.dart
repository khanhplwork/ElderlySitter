import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:flutter/cupertino.dart';

import '../../core/models/booking_models/booking_form_data_model.dart';

abstract class BookingEvent {}

class TestGetAllBookingEvent extends BookingEvent {}

class ChooseStartTimeBookingEvent extends BookingEvent {
  ChooseStartTimeBookingEvent({required this.time});

  String time;
}

class OtherBookingEvent extends BookingEvent {}

class AddTimeBookingEvent extends BookingEvent {
  AddTimeBookingEvent(
      {required this.booking,
      required this.context,
      required this.packageName,
      required this.elderName,
      required this.totalPrice});

  BookingDataModel booking;
  BuildContext context;
  String packageName;
  String elderName;
  double totalPrice;
}

class AddTimeWeekBookingEvent extends BookingEvent {
  AddTimeWeekBookingEvent(
      {required this.booking,
      required this.context,
      required this.packageName,
      required this.elderName,
      required this.totalPrice});

  BookingDataModel booking;
  BuildContext context;
  String packageName;
  String elderName;
  double totalPrice;
}

class ChooseDateOnlyBookingEvent extends BookingEvent {
  ChooseDateOnlyBookingEvent({required this.pickedDate});

  DateTime pickedDate;
}

class CreateBookingEvent extends BookingEvent {
  CreateBookingEvent({required this.booking, required this.context});

  BookingDataModel booking;
  BuildContext context;
}

class AddEstimateTime extends BookingEvent {
  AddEstimateTime({required this.estimate});

  final int estimate;
}

class GetListBookingByStatusBookingEvent extends BookingEvent {
  GetListBookingByStatusBookingEvent({required this.status});

  final String status;
}

class GetFullDetailBookingEvent extends BookingEvent {
  GetFullDetailBookingEvent({required this.bookingID});

  final String bookingID;
}

class CusPaidForBookingEvent extends BookingEvent {
  CusPaidForBookingEvent(
      {required this.context,
      required this.bookingID,
      required this.paymentMethod,
      required this.type});

  final BuildContext context;
  final String bookingID;
  final String paymentMethod;
  final String type;
}

class ChooseMultiDateBookingEvent extends BookingEvent {
  ChooseMultiDateBookingEvent({required this.pickedDate});

  final DateTime pickedDate;
}

class GetAllHistoryBookingEvent extends BookingEvent {
  GetAllHistoryBookingEvent();
}

class FillDescriptionBookingEvent extends BookingEvent {
  FillDescriptionBookingEvent({required this.description});

  final String description;
}

class GetAllSlotWorking extends BookingEvent {}

class FixTimeAllDay extends BookingEvent {
  FixTimeAllDay(this.numDay);

  final numDay;
}

class ChooseTimeOnlyBooking extends BookingEvent {
  ChooseTimeOnlyBooking(this.slotSelected);

  final SlotDataModel slotSelected;
}

class ChooseTimeMultiBooking extends BookingEvent {
  ChooseTimeMultiBooking(this.slotSelected);

  final SlotDataModel slotSelected;
}

class CusCancelBooking extends BookingEvent {
  CusCancelBooking(
      {required this.context, required this.bookingID, required this.reason});

  final BuildContext context;
  final String bookingID;
  final String reason;
}

class GetAllHistoryByStatusBookingEvent extends BookingEvent {
  GetAllHistoryByStatusBookingEvent({required this.status});

  final String status;
}

class ClickReduceDayOptionEvent extends BookingEvent {
  ClickReduceDayOptionEvent({required this.idBooking, required this.context});

  final String idBooking;
  BuildContext context;
}

class CusChangeSitterEvent extends BookingEvent {
  CusChangeSitterEvent({required this.context, required this.bookingID});

  final BuildContext context;
  final String bookingID;
}

class FetchDataHistory extends BookingEvent {
  FetchDataHistory({required this.status});

  final String status;
}

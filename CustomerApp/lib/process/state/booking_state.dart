import 'package:elscus/core/models/booking_models/add_booking_detail_dto.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_model.dart';
import 'package:elscus/core/models/booking_models/booking_history_model.dart';
import 'package:elscus/core/models/booking_models/pending_booking_model.dart';
import 'package:elscus/core/models/working_time_model/slot_data_model.dart';

import '../../core/models/test_models/test_schedule_model.dart';

abstract class BookingState {}

class TestGetAllBookingState extends BookingState {
  TestGetAllBookingState({required this.testModel});

  final TestScheduleModel testModel;
}

class ChooseStartTimeBookingState extends BookingState {
  ChooseStartTimeBookingState({required this.hour, required this.minute});

  String hour;
  String minute;
}

class GetListPendingBookingBookingState extends BookingState {
  GetListPendingBookingBookingState({required this.listBooking});

  final PendingBookingModel listBooking;
}

class OtherBookingState extends BookingState {}

class ChooseMultiDateBookingState extends BookingState {
  ChooseMultiDateBookingState({required this.listWorkingDate});

  final Map<DateTime, AddBookingDetailDto> listWorkingDate;
}

class GetFullDetailBookingState extends BookingState {
  GetFullDetailBookingState({required this.booking});

  final BookingFullDetailModel booking;
}

class GetAllHistoryBookingState extends BookingState {
  GetAllHistoryBookingState({required this.bookingHistoryList});

  final BookingHistoryModel bookingHistoryList;
}

class LoadingDataState extends BookingState {}

class HaveSlotWorkingState extends BookingState {
  HaveSlotWorkingState({required this.listSlot});

  final List<SlotDataModel> listSlot;
}

class ChangeStateRatioFixDayState extends BookingState {}

class GetAllHistoryByStatusBookingState extends BookingState {
  GetAllHistoryByStatusBookingState({required this.bookingHistoryList});

  final BookingHistoryModel bookingHistoryList;
}

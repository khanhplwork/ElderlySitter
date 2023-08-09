import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:flutter/Material.dart';

abstract class ConfirmPayEvent {}

class OtherConfirmPayEvent extends ConfirmPayEvent{}

class FetchDataWalletEvent extends ConfirmPayEvent{}
class FetchCouponEvent extends ConfirmPayEvent{}
class ClickPaymentEvent extends ConfirmPayEvent{
  ClickPaymentEvent({required this.bookingInputBloc,required this.context});
  BuildContext context;
  BookingInputInforBloc bookingInputBloc;
}
class ClickPaymentIncreseEvent extends ConfirmPayEvent{
  ClickPaymentIncreseEvent({required this.bookingInputBloc,required this.context,required this.bookingID});
  BuildContext context;
  BookingInputInforBloc bookingInputBloc;
  String bookingID;
}

class ClickChoosePromotion extends ConfirmPayEvent{
  ClickChoosePromotion({required this.bookingInputBloc,required this.context});
  BuildContext context;
  BookingInputInforBloc bookingInputBloc;
}

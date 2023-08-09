import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';

abstract class BookingElderState {}
class OtherBookingElderState extends BookingElderState{}
class LoadingDataState extends BookingElderState{}
class ErrorState extends BookingElderState{}
class LoadedDataState extends BookingElderState{
  LoadedDataState({required this.listElder});
  List<ElderModelV2> listElder;
}
class NotHaveDataState extends BookingElderState{}
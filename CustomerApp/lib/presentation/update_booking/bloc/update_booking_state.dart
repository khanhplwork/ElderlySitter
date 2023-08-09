// UpdateBookingState
abstract class UpdateBookingState{}

class OtherUpdateBookingState extends UpdateBookingState{}
// class AcceptReduceBookingState extends UpdateBookingState{
//   CheckUpdateBookingState({required this.isReduce});
//   bool isReduce;
// }
//
class ErrorState extends UpdateBookingState{}
class InitLoadingState extends UpdateBookingState{}
class CheckChangeDateState extends UpdateBookingState{
  CheckChangeDateState({required this.isChanged});
  final bool isChanged;
}


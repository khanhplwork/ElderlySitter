abstract class BookingInputInforState{}

class OtherBookingInputInforState extends BookingInputInforState{}
class LoadingInitBookingInputState extends BookingInputInforState{}

class EnableCheckPriceState extends BookingInputInforState{}

class AvailbleCheckPriceState extends BookingInputInforState{
  AvailbleCheckPriceState({required this.isWaittingCheck});
  bool isWaittingCheck;
}
class WaitingCheckPriceState extends BookingInputInforState{}
class AvailbleGoPayState extends BookingInputInforState{}




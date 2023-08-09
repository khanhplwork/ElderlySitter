import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:flutter/Material.dart';

abstract class BookingPackageEvent{}

class OtherBookingPackageEvent extends BookingPackageEvent{}
class FetchBookingPackageEvent extends BookingPackageEvent{
  FetchBookingPackageEvent({required this.statusHealth});
  String statusHealth;
}
class ClickChooseBookingPackageEvent extends BookingPackageEvent{
  ClickChooseBookingPackageEvent({required this.context,required this.package});
  final PackageModelV2 package;
  BuildContext context;
}

import 'dart:async';

import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_input_infor.dart';
import 'package:elscus/presentation/booking_v2/choose_package/api/booking_package_api.dart';
import 'package:elscus/presentation/booking_v2/choose_package/bloc/booking_package_event.dart';
import 'package:elscus/presentation/booking_v2/choose_package/bloc/booking_package_state.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:flutter/Material.dart';

class BookingPackageBloc {
  final eventController = StreamController<BookingPackageEvent>();

  final stateController = StreamController<BookingPackageState>();

  String errorMessage = "";

  List<PackageModelV2> list = [];
  late ElderModelV2 elder;

  BookingPackageBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherBookingPackageEvent) {
        stateController.sink.add(OtherBookingPackageState());
      } else if (event is FetchBookingPackageEvent) {
        try {
          list = await BookingPackageApi.fetchListPackage(event.statusHealth);
        //  list = [PackageModelV2(img:"",id: "id", name: "name", startTime: "startTime", endTime: "endTime", startSlot: 1, endSlot: 2, duration: 2, price: 2, healthStatus: "healthStatus", desc: "desc", service: ["service","sẻvice2"],)];
          if (list.isNotEmpty) {
            stateController.sink.add(OtherBookingPackageState());
          } else {
            throw Exception("Không có sẵn các gói dịch vụ");
          }
        } catch (e) {
          errorMessage = e.toString().split(":")[1];
          stateController.sink.add(ErrorBookingPackageState());
        }
      }else if(event is ClickChooseBookingPackageEvent){
           Navigator.push(
                        event.context,
                        MaterialPageRoute(
                          builder: (context) => BookingInputScreen(package: event.package,elder: elder,),
                        ));
      }
    });
  }
}

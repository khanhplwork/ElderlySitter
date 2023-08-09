import 'dart:async';

import 'package:elscus/presentation/booking_v2/choose_elder/api/booking_elder_api.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_event.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/bloc/booking_elder_state.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/screen/booking_elder.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_package/screen/booking_package.dart';
import 'package:flutter/Material.dart';

class ElderBookingBloc {
  final eventController = StreamController<BookingElderEvent>();

  final stateController = StreamController<BookingElderState>();
  List<ElderModelV2> list =[];
  String error="";
  ElderBookingBloc() {
    eventController.stream.listen(
      (event) async {
        if (event is OtherBookingElderEvent) {
          stateController.sink
              .add(OtherBookingElderState()); //Test schedule event
        }else if(event is FetchDataEvent){
          try{
            list =await BookingElderApi.fetchListElder();
            if(list.isEmpty){
             throw Exception("Chua co nguoi than");
            }else{
            stateController.sink.add(OtherBookingElderState());
            }
          }catch( e){
              error=e.toString().split(":")[1];
              stateController.sink.add(ErrorState());
          }
        }else if(event is ClickSubmitElderEvent){
           Navigator.push(
                        event.context,
                        MaterialPageRoute(
                          builder: (context) => BookingPackageScreen(elder: event.elder),
                        ));
        }
        
      },
    );
  }

}

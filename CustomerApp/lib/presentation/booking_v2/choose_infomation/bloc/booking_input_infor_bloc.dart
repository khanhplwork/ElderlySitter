import 'dart:async';

import 'package:elscus/core/models/elder_models/elder_model.dart';
import 'package:elscus/core/models/working_time_model/slot_data_model.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/api/booking_input_api.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_event.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_state.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/checkprice_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/model/data_search_model.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_pick_time.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/globals.dart' as globals;

class BookingInputInforBloc {
  final eventController = StreamController<BookingInputInforEvent>();
  final stateController = StreamController<BookingInputInforState>();
  List<DateTime?> dates = [];
  List<DateTime?> datesFinal = [];
  List<SlotDataModel> listSlot = [];
  List<DataSearchModel> listLocation = [];
  // DateFormat("dd-MM-yyyy").format(DateTime.now());
  String titleDate = "";
  String titleAddress = "";
  String titleSlot = "";
  SlotDataModel slotPicked = SlotDataModel(slots: "");
  late PackageModelV2 package;
  bool isMultiChoose = true;
  bool isRangeChoose = false;
  bool isCheckedPrice = false;
  bool isEnableCheckPriceButton = false;
  double tmpPrice = 0;
  DataSearchModel? modelSearch;
  CheckPriceModel? checkPriceModel;
  late ElderModelV2 elder;
  String description = "";
  String errorMessage = "";
  int maximum = 250;
  TextEditingController textController = TextEditingController();
  bool isDefaultAddress =true;
  BookingInputInforBloc() {
    eventController.stream.listen(
      (event) async {
        if (event is OtherBookingInputInforEvent) {
          isEnableCheckPriceButton = checkValidate();
          print("status ${isEnableCheckPriceButton}");

          stateController.sink.add(OtherBookingInputInforState());
        } else if (event is ClickOpenFormPickTimeEvent) {
        } else if (event is ClickOpenFormPickAddressEvent) {
        } else if (event is UpdateEvent) {
          datesFinal = [];
          isCheckedPrice = false;
          if (dates.isEmpty) {
            titleDate = "";
          } else if (dates.length == 1) {
            datesFinal.add(dates[0]);
            titleDate = DateFormat("dd-MM-yyyy").format(dates[0]!);
          } else {
            if (isMultiChoose) {
              titleDate =
                  "${DateFormat("dd-MM-yyyy").format(dates[0]!)} và ${dates.length - 1} ngày khác";
              dates.forEach((element) {
                datesFinal.add(element);
              });
            } else {
              var numday = dates.last!.difference(dates.first!).inDays + 1;
              for (var i = 0; i < numday; i++) {
                datesFinal.add(dates.first!.add(Duration(days: i)));
              }
              print("datefinal" + datesFinal.toString());
              titleDate =
                  "${DateFormat("dd-MM-yyyy").format(dates[0]!)} -> ${DateFormat("dd-MM-yyyy").format(dates.last!)}";
            }
          }
          eventController.sink.add(OtherBookingInputInforEvent());
        } else if (event is FetchSlotDataEvent) {
          List<SlotDataModel> listTmp =
              await BookingInputApi.fetchListSlotData();

          listTmp.forEach((element) {
            if (int.parse(element.slots.split(" ")[0]) >= package.slotStart! &&
                int.parse(element.slots.split(" ")[0]) <= package.slotEnd!) {
              listSlot.add(element);
            }
          });
          eventController.sink.add(OtherBookingInputInforEvent());
        } else if (event is PickSlotEvent) {
          isCheckedPrice = false;
          slotPicked = event.slotPicked;
          print(slotPicked.slots);
          titleSlot = slotPicked.slots.split(" ")[1];
          eventController.sink.add(OtherBookingInputInforEvent());
        } else if (event is ClickMultiPick) {
          isCheckedPrice = false;
          isMultiChoose = !isMultiChoose;
          isRangeChoose = !isMultiChoose;
          dates = [];
          eventController.sink.add(OtherBookingInputInforEvent());
        } else if (event is ClickRangePick) {
          isCheckedPrice = false;
          isRangeChoose = !isRangeChoose;
          isMultiChoose = !isRangeChoose;
          dates = [];
          eventController.sink.add(OtherBookingInputInforEvent());
        } else if (event is ClickCheckPrice) {
          //await check gia
          if (!event.isUpdate) {
            if (isEnableCheckPriceButton) {
              print(datesFinal);
              stateController.sink.add(WaitingCheckPriceState());
              String startTime = slotPicked.slots.split(" ")[1].split("-")[0];
              List<String> datesString = [];
              datesFinal.forEach((element) {
                datesString.add(DateFormat("yyyy-MM-dd").format(element!));
              });
              print(datesString);
              checkPriceModel = await BookingInputApi.checkPrice(
                  package.id!, startTime, datesString,null);

              isCheckedPrice = true;
            }
          } else {
            isEnableCheckPriceButton=true;
            checkPriceModel = await BookingInputApi.checkPrice(
                  package.id!, event.startTime, event.dateUpdate,null);
              isCheckedPrice = true;
          }
              event.dateUpdate.forEach((element) {
                datesFinal.add(DateFormat("yyyy-MM-dd").parse(element));
              });
              eventController.sink.add(OtherBookingInputInforEvent());

        }
      },
    );
  }
  setStringDescription(String value) {

    if (value.length <= maximum) {
      description = value;
      errorMessage = "";
    } else {
      textController.text = description;
      errorMessage = "Tối đa ${maximum} kí tự";
    }
    stateController.sink.add(OtherBookingInputInforState());
  }
  bool checkValidate() {
    if (titleSlot.isEmpty || titleDate.isEmpty||titleAddress.isEmpty) {
      return false;
    } else {
      //await check gia
      return true;
    }
  }
  setDefaultAddress(){
    titleAddress=globals.cusDetailModel!.address;
    modelSearch=DataSearchModel(
      lat: globals.cusDetailModel!.latitude,
      lng: globals.cusDetailModel!.longitude,
          description: globals.cusDetailModel!.address,
          placeId: "",
          reference: "",
          structuredFormatting: StructuredFormatting(
              mainText: globals.cusDetailModel!.address.split(",")[0], secondaryText: globals.cusDetailModel!.address),
          compound: Compound(district: globals.cusDetailModel!.zone, commune: "", province: ""),
          types: []);
  }
}

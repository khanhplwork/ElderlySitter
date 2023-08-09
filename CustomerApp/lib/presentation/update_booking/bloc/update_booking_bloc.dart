import 'dart:async';

import 'package:elscus/core/models/date_check_models/date_check_editting.dart';
import 'package:elscus/core/models/date_check_models/date_check_increase.dart';
import 'package:elscus/presentation/booking_v2/choose_elder/model/elder_model_v2.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/screen/booking_input_infor.dart';
import 'package:elscus/presentation/booking_v2/choose_package/model/package_model_v2.dart';
import 'package:elscus/presentation/success_screen/success_screen.dart';
import 'package:elscus/presentation/update_booking/api/update_booking_api.dart';
import 'package:elscus/presentation/update_booking/bloc/update_booking_event.dart';
import 'package:elscus/presentation/update_booking/bloc/update_booking_state.dart';
import 'package:elscus/presentation/widget/dialog/fail_dialog.dart';
import 'package:elscus/presentation/widget/dialog/notice_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class UpdateBookingBloc {
  final eventController = StreamController<UpdateBookingEvent>();
  final stateController = StreamController<UpdateBookingState>();
  List<DateTime> listDateCheckOrigin = [];
  List<DateTime> listDateUpdateAccept = [];
  String idBooking = "";
  String errorMessage = "";
  late DateCheckEditing dateCheckingUpdate;
  late CheckIncreaseEditting dateCheckingIncrease;
  bool isChanged = false;

  UpdateBookingBloc() {
    eventController.stream.listen((event) async {
      if (event is OtherUpdateBookingEvent) {
        stateController.sink.add(OtherUpdateBookingState());
      }
      if (event is CheckReduceEvent) {
        try {
          listDateCheckOrigin = [];
          dateCheckingUpdate = await UpdateBookingApi.checkReduceDay(idBooking);
          dateCheckingUpdate.dates.forEach((element) {
            listDateCheckOrigin.add(DateFormat("yyyy-MM-dd").parse(element));
          });
          listDateUpdateAccept = listDateCheckOrigin;
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
        stateController.sink.add(OtherUpdateBookingState());
      }
      if (event is ClickChangeReduceEvent) {
        List<DateTime?> listTmp = event.listDates;
        bool isContain = false;
        listTmp.forEach((element) {
          if (!listDateCheckOrigin.contains(element)) {
            isContain = true;
            print(element);
          }
        });
        if (isContain) {
          errorMessage = "Bạn chỉ có thể loại bỏ các ngày sẵn có";
          stateController.sink.add(OtherUpdateBookingState());
        } else {
          if (listDateCheckOrigin.length - listTmp.length >
              dateCheckingUpdate.numberOfReduce) {
            errorMessage =
                "Số ngày tối đa bạn có thể giảm là ${dateCheckingUpdate.numberOfReduce}";
            stateController.sink.add(OtherUpdateBookingState());
          } else {
            errorMessage = "";
            print("e");
            listDateUpdateAccept = [];
            listTmp.forEach((element) {
              listDateUpdateAccept.add(element!);
            });
            stateController.sink.add(OtherUpdateBookingState());
          }
        }
        isContain = false;
        if (listEquals(listTmp, listDateCheckOrigin)) {
          isChanged = false;
        } else {
          isChanged = true;
        }
      }
      if (event is ClickUpdate) {
        List<String> datePost = [];
        try {
          listDateCheckOrigin.forEach(
            (element) {
              if (!listDateUpdateAccept.contains(element)) {
                datePost.add(DateFormat("yyyy-MM-dd").format(element));
              }
            },
          );
          // print(listDateUpdateAccept);
          // print(datePost);
          await UpdateBookingApi.updateBooking(idBooking, datePost);
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(
                builder: (context) => const SuccessScreen(
                    content: "Cập nhật thành công",
                    buttonName: "Trang chủ",
                    navigatorPath: '/homeScreen'),
              ),
              (route) => false);
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
      }
      if (event is ClickUpdateIncrease) {
        List<String> datePost = [];
        try {
          listDateUpdateAccept.forEach(
            (element) {
              if (!listDateCheckOrigin.contains(element)) {
                datePost.add(DateFormat("yyyy-MM-dd").format(element));
              }
            },
          );
          // print(listDateUpdateAccept);
          print(datePost);
          // await UpdateBookingApi.updateBooking(idBooking, datePost);
          if (datePost.isNotEmpty) {
            Navigator.push(
              event.context,
              MaterialPageRoute(
                  builder: (context) => BookingInputScreen(
                        bookingID: event.bookingFull.id,
                        slotTitle:
                            "${event.bookingFull.startTime.split(":")[0]}:${event.bookingFull.startTime.split(":")[1]}-${int.parse(event.bookingFull.startTime.split(":")[0]) + 2}:${event.bookingFull.startTime.split(":")[1]}",
                        addressTile: event.bookingFull.address,
                        dateTitle:
                            "${datePost.first} và ${datePost.length - 1} ngày khác",
                        datesPostUp: datePost,
                        package: PackageModelV2(
                          id: event.bookingFull.bookingDetailFormDtos[0]
                              .packageDto.id,
                          name: event.bookingFull.bookingDetailFormDtos[0]
                              .packageDto.name,
                          price: event.bookingFull.bookingDetailFormDtos[0]
                              .packageDto.price,
                        ),
                        elder: ElderModelV2(
                            id: event.bookingFull.elderDto.id,
                            fullName: event.bookingFull.elderDto.fullName,
                            dob: DateTime.now(),
                            healthStatus:
                                event.bookingFull.elderDto.healthStatus,
                            gender: event.bookingFull.elderDto.gender),
                        isLockUpdate: true,
                      )),
            );
          } else {
            showNoticeDialog(event.context, "Chưa có ngày nào được chọn");
          }
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
      }
      //ClickChangeIncreaseEvent

      if (event is ClickChangeIncreaseEvent) {
        List<DateTime?> listTmp = event.listDates;
        print(listTmp);
        bool isNotContainOrigin = true;

        listDateCheckOrigin.forEach((element) {
          if (!listTmp.contains(element)) {
            isNotContainOrigin = false;
          }
        });
        if (isNotContainOrigin) {
          errorMessage = "";
          listDateUpdateAccept = [];
          listTmp.forEach((element) {
            listDateUpdateAccept.add(element!);
          });
          stateController.sink.add(OtherUpdateBookingState());
        } else {
          errorMessage = "Bạn không thể loại bỏ các ngày sẵn có";
          stateController.sink.add(OtherUpdateBookingState());
          // if (listDateCheckOrigin.length - listTmp.length >
          //     dateCheckingUpdate.numberOfReduce) {
          //   errorMessage =
          //       "Số ngày tối đa bạn có thể giảm là ${dateCheckingUpdate.numberOfReduce}";
          //   stateController.sink.add(OtherUpdateBookingState());
          // } else {
          //   errorMessage = "";
          //   print("e");
          //   listDateUpdateAccept = [];
          //   listTmp.forEach((element) {
          //     listDateUpdateAccept.add(element!);
          //   });
          //   stateController.sink.add(OtherUpdateBookingState());
          // }
        }
        isNotContainOrigin = false;
        if (listEquals(listTmp, listDateCheckOrigin)) {
          isChanged = false;
        } else {
          isChanged = true;
        }
      }
      if (event is CheckIncreaseEvent) {
        try {
          listDateCheckOrigin = [];
          dateCheckingIncrease =
              await UpdateBookingApi.checkIncreaseDay(idBooking);
          dateCheckingIncrease.dates.forEach((element) {
            listDateCheckOrigin.add(DateFormat("yyyy-MM-dd").parse(element));
          });
          listDateUpdateAccept = listDateCheckOrigin;
        } catch (e) {
          Navigator.pop(event.context);
          await showFailDialog(
              event.context,
              e.toString().contains(":")
                  ? e.toString().split(":")[1]
                  : e.toString());
        }
        stateController.sink.add(OtherUpdateBookingState());
      }
    });
  }
}

import 'dart:collection';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/models/booking_models/booking_full_detail_data_model.dart';
import 'package:elscus/presentation/update_booking/bloc/update_booking_bloc.dart';
import 'package:elscus/presentation/update_booking/bloc/update_booking_event.dart';
import 'package:elscus/presentation/update_booking/bloc/update_booking_state.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpdateBookingScreen extends StatefulWidget {
  UpdateBookingScreen(
      {super.key,
      required this.bookingBloc,
      required this.idBooking,
      required this.isReduce,
      required this.dataBooking});

  BookingBloc bookingBloc;
  String idBooking;
  bool isReduce;
  BookingFullDetailDataModel dataBooking;

  @override
  State<UpdateBookingScreen> createState() => _UpdateBookingScreenState(
      bookingBloc: bookingBloc,
      idBooking: idBooking,
      isReduce: isReduce,
      dataBooking: dataBooking);
}

class _UpdateBookingScreenState extends State<UpdateBookingScreen> {
  _UpdateBookingScreenState(
      {required this.bookingBloc,
      required this.idBooking,
      required this.isReduce,
      required this.dataBooking});

  String idBooking;
  BookingBloc bookingBloc;
  final updateBloc = UpdateBookingBloc();
  bool isReduce;
  BookingFullDetailDataModel dataBooking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBloc.idBooking = idBooking;
    if (isReduce) {
      updateBloc.eventController.add(CheckReduceEvent(context: context));
    } else {
      updateBloc.eventController.add(CheckIncreaseEvent(context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Điều chỉnh ngày"),
          backgroundColor: ColorConstant.primaryColor,
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          width: size.width,
          padding: EdgeInsets.only(
            top: size.height * 0.03,
            bottom: size.height * 0.03,
            left: size.width * 0.07,
            right: size.width * 0.07,
          ),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            width: 1,
            color: ColorConstant.primaryColor.withOpacity(0.2),
          ))),
          child: ElevatedButton(
            onPressed: () {
              if(updateBloc.isChanged){
                if (isReduce) {
                  updateBloc.eventController.sink
                      .add(ClickUpdate(context: context));
                } else {
                  updateBloc.eventController.sink.add(ClickUpdateIncrease(
                      context: context, bookingFull: dataBooking));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (updateBloc.isChanged)
                  ? ColorConstant.primaryColor
                  : Colors.grey,
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                bottom: size.height * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.height * 0.01),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Xác nhận",
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<Object>(
            stream: updateBloc.stateController.stream,
            initialData: InitLoadingState(),
            builder: (context, snapshot) {
              print("object");
              if (snapshot.data is InitLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.primaryColor,
                  ),
                );
              }
              if (snapshot.data is OtherUpdateBookingState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        isReduce
                            ? CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  currentDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: updateBloc.listDateCheckOrigin.last,
                                  calendarType: CalendarDatePicker2Type.multi,
                                  selectedDayTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                  selectedDayHighlightColor:
                                      ColorConstant.primaryColor,
                                  centerAlignModePicker: true,
                                ),
                                value: updateBloc.listDateUpdateAccept,
                                onValueChanged: (dates) {
                                  setState(() {
                                    updateBloc.eventController.sink.add(
                                        ClickChangeReduceEvent(
                                            context: context, listDates: dates));
                                  });
                                },
                              )
                            : Column(
                                children: [
                                  Text(
                                      "Việc thêm ngày sẽ tạo 1 booking mới có thể khác sitter"),
                                  CalendarDatePicker2(
                                    config: CalendarDatePicker2Config(
                                      currentDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateFormat('yyyy-MM-dd').parse(
                                          updateBloc
                                              .dateCheckingIncrease.maxDate),
                                      calendarType:
                                          CalendarDatePicker2Type.multi,
                                      selectedDayTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      selectedDayHighlightColor:
                                          ColorConstant.primaryColor,
                                      centerAlignModePicker: true,
                                    ),
                                    value: updateBloc.listDateUpdateAccept,
                                    onValueChanged: (dates) {
                                      setState(() {
                                        updateBloc.eventController.sink.add(
                                            ClickChangeIncreaseEvent(
                                                context: context,
                                                listDates: dates));
                                      });
                                    },
                                  ),
                                ],
                              ),
                        updateBloc.errorMessage.isNotEmpty
                            ? Text(updateBloc.errorMessage)
                            : SizedBox()
                      ],
                    ),
                  ),
                );
              }
              return SizedBox();
            }));
  }
}

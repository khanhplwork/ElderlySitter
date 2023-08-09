import 'dart:collection';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:elscus/core/constants/color_constant.dart';
import 'package:elscus/core/utils/utils.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_bloc.dart';
import 'package:elscus/presentation/booking_v2/choose_infomation/bloc/booking_input_infor_event.dart';
import 'package:elscus/presentation/splash_screen/splash_screen.dart';
import 'package:elscus/process/bloc/booking_bloc.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPickTimeScreen extends StatefulWidget {
  BookingPickTimeScreen({super.key, required this.bookingInputBloc});
  BookingInputInforBloc bookingInputBloc;
  @override
  State<BookingPickTimeScreen> createState() =>
      _BookingPickTimeScreenState(bookingInputBloc: bookingInputBloc);
}

class _BookingPickTimeScreenState extends State<BookingPickTimeScreen> {
  _BookingPickTimeScreenState({required this.bookingInputBloc});
  BookingInputInforBloc bookingInputBloc;
  List<DateTime?> _dates = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingInputBloc.eventController.sink.add(UpdateEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Chọn ngày"),
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
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      size: size.height * 0.03,
                      color: ColorConstant.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Quý khách chỉ được tối đa 30 ngày",
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chọn nhanh nhiều ngày",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Switch(
                    // This bool value toggles the switch.
                    value: bookingInputBloc.isRangeChoose,
                    activeColor: ColorConstant.primaryColor,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      bookingInputBloc.eventController.sink
                          .add(ClickRangePick());
                      setState(() {});
                    },
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chọn theo ngày",
                          style: GoogleFonts.roboto(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Switch(
                    // This bool value toggles the switch.
                    value: bookingInputBloc.isMultiChoose,
                    activeColor: ColorConstant.primaryColor,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      bookingInputBloc.eventController.sink
                          .add(ClickMultiPick());
                      setState(() {});
                    },
                  ),
                ),
                CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    currentDate: DateTime.now().add(Duration(days: 2)),
                    firstDate: DateTime.now().add(Duration(days: 2)),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                    calendarType: bookingInputBloc.isMultiChoose
                        ? CalendarDatePicker2Type.multi
                        : CalendarDatePicker2Type.range,
                    selectedDayTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    selectedDayHighlightColor: ColorConstant.primaryColor,
                    centerAlignModePicker: true,
                  ),
                  value: bookingInputBloc.dates,
                  onValueChanged: (dates) {
                    setState(() {
                      bookingInputBloc.dates = dates;
                      bookingInputBloc.eventController.sink.add(UpdateEvent());
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
